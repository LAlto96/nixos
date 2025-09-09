#!/usr/bin/env bash
# Mute Vesktop/Discord via PipeWire (auto-detect):
# - Output (lecture): set-volume 0% / 100%
# - Input  (micro)  : set-mute   1 / 0    (option --input-volume pour 0%/100% aussi)
# toggle: coupe si un flux actif (OUT vol>0 ou IN non-muted), sinon remet.
# Deps: hyprctl, pw-dump, jq, wpctl, awk

set -u
ACTION="${1:-toggle}"; case "$ACTION" in toggle|on|off) shift || true ;; *) ACTION="toggle" ;; esac

ONLY_PLAYBACK=false; ONLY_CAPTURE=false; VERBOSE=false; DRYRUN=false; INPUT_VOLUME=false
WIN_REGEX=${WIN_REGEX:-"Vesktop|Discord|discord|vesktop"}
APP_REGEX=${APP_REGEX:-"vesktop|discord|vencord|chromium|electron"}
IDS_OVERRIDE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --playback|-p) ONLY_PLAYBACK=true; shift ;;
    --capture|-c)  ONLY_CAPTURE=true;  shift ;;
    --win)         WIN_REGEX="$2"; shift 2 ;;
    --app)         APP_REGEX="$2"; shift 2 ;;
    --ids)         IDS_OVERRIDE="$2"; shift 2 ;;   # ex: "66:OUT,149:IN" ou "66,149" (OUT par défaut)
    --verbose|-v)  VERBOSE=true; shift ;;
    --dry-run)     DRYRUN=true; shift ;;
    --input-volume) INPUT_VOLUME=true; shift ;;
    *) echo "Unknown arg: $1"; exit 2 ;;
  esac
done

need(){ command -v "$1" >/dev/null 2>&1 || { echo "Error: '$1' required." >&2; exit 1; }; }
need pw-dump; need jq; need wpctl; need awk; need hyprctl

get_vol(){ wpctl get-volume "$1" 2>/dev/null | awk '{print $2}'; }  # -> 0.00..1.xx
is_gt_zero(){ awk -v v="$1" 'BEGIN{exit !(v>0.0001)}'; }
is_muted_flag(){ wpctl get-volume "$1" 2>/dev/null | grep -q '\[MUTED\]' && echo 1 || echo 0; }

OUT_IDS=(); IN_IDS=(); DETECTION_MODE=""

# 0) --ids bypass
if [[ -n "$IDS_OVERRIDE" ]]; then
  IFS=',' read -r -a raw <<<"$IDS_OVERRIDE"
  for spec in "${raw[@]}"; do
    id="${spec%%:*}"; kind="${spec#*:}"
    if [[ "$spec" == "$id" ]]; then
      mc=$(pw-dump | jq -r --argjson nid "$id" '.[] | select(.id==$nid) | .info.props["media.class"] // empty' 2>/dev/null || true)
      if [[ "$mc" =~ [Ii]nput ]]; then IN_IDS+=("$id"); else OUT_IDS+=("$id"); fi
    else
      [[ "${kind^^}" == "IN" ]] && IN_IDS+=("$id") || OUT_IDS+=("$id")
    fi
  done
  DETECTION_MODE="ids"
else
  # 1) PIDs via Hyprland
  mapfile -t PID_LIST < <(hyprctl clients -j | jq -r --arg re "$WIN_REGEX" '
    map(select((.class // "" | test($re; "i")) or (.title // "" | test($re; "i")))) | .[].pid' | awk 'NF')
  $VERBOSE && { echo "Hyprland regex: /$WIN_REGEX/i"; ((${#PID_LIST[@]})) && echo "PIDs: ${PID_LIST[*]}" || echo "No PID matched, will try regex fallback."; }

  NODES=()
  if ((${#PID_LIST[@]})); then
    pid_json=$(printf '%s\n' "${PID_LIST[@]}" | jq -R -s 'split("\n")|map(select(length>0))|map(tonumber)')
    mapfile -t NODES < <(pw-dump | jq -r --argjson pids "$pid_json" '
      .[] | select(.type=="PipeWire:Interface:Node") as $n
      | ($n.info.props["media.class"] // "") as $mc
      | select($mc | test("Audio"; "i"))
      | ($n.info.props["application.process.id"] // -1) as $pid
      | select($pid != -1 and (any($pids[]; . == $pid)))
      | "\(.id)\t\($mc)"' )
    DETECTION_MODE="pids"
    if [[ ${#NODES[@]} -eq 0 ]]; then
      $VERBOSE && echo "No nodes for PIDs; fallback regex: /$APP_REGEX/i"
      mapfile -t NODES < <(pw-dump | jq -r --arg appre "($APP_REGEX)" '
        .[] | select(.type=="PipeWire:Interface:Node") as $n
        | ($n.info.props["media.class"] // "") as $mc
        | select($mc | test("Audio"; "i"))
        | ($n.info.props["application.name"] // "") as $an
        | ($n.info.props["application.process.binary"] // "") as $bin
        | ($n.info.props["node.name"] // "") as $nn
        | select(($an|test($appre; "i")) or ($bin|test($appre; "i")) or ($nn|test($appre; "i")))
        | "\(.id)\t\($mc)"' )
      DETECTION_MODE="regex"
    fi
  else
    mapfile -t NODES < <(pw-dump | jq -r --arg appre "($APP_REGEX)" '
      .[] | select(.type=="PipeWire:Interface:Node") as $n
      | ($n.info.props["media.class"] // "") as $mc
      | select($mc | test("Audio"; "i"))
      | ($n.info.props["application.name"] // "") as $an
      | ($n.info.props["application.process.binary"] // "") as $bin
      | ($n.info.props["node.name"] // "") as $nn
      | select(($an|test($appre; "i")) or ($bin|test($appre; "i")) or ($nn|test($appre; "i")))
      | "\(.id)\t\($mc)"' )
    DETECTION_MODE="regex"
  fi

  # 2) Split OUT/IN
  for line in "${NODES[@]}"; do
    [[ -z "$line" ]] && continue
    id="${line%%$'\t'*}"; mc="${line#*$'\t'}"
    $ONLY_PLAYBACK && [[ ! "$mc" =~ [Oo]utput ]] && continue
    $ONLY_CAPTURE  && [[ ! "$mc" =~ [Ii]nput  ]] && continue
    if [[ "$mc" =~ [Ii]nput ]]; then IN_IDS+=("$id"); else OUT_IDS+=("$id"); fi
  done
fi

# uniq
((${#OUT_IDS[@]})) && mapfile -t OUT_IDS < <(printf '%s\n' "${OUT_IDS[@]}" | awk 'NF' | sort -n | uniq)
((${#IN_IDS[@]}))  && mapfile -t IN_IDS  < <(printf '%s\n' "${IN_IDS[@]}"  | awk 'NF' | sort -n | uniq)

if [[ ${#OUT_IDS[@]} -eq 0 && ${#IN_IDS[@]} -eq 0 ]]; then
  $VERBOSE && echo "No targets (mode=$DETECTION_MODE, win=/$WIN_REGEX/i, app=/$APP_REGEX/i)."
  exit 0
fi

$VERBOSE && {
  echo "Targets (mode=$DETECTION_MODE):"
  ((${#OUT_IDS[@]})) && echo "  OUT: ${OUT_IDS[*]}"
  ((${#IN_IDS[@]}))  && echo "  IN : ${IN_IDS[*]}"
}

# 3) Decide toggle
CUT=false
if [[ "$ACTION" == "toggle" ]]; then
  any_active=0
  for id in "${OUT_IDS[@]}"; do v="$(get_vol "$id" || echo "1.00")"; is_gt_zero "$v" && { any_active=1; break; }; done
  if (( ! any_active )); then
    for id in "${IN_IDS[@]}"; do
      if $INPUT_VOLUME; then v="$(get_vol "$id" || echo "1.00")"; is_gt_zero "$v" && { any_active=1; break; }
      else [[ "$(is_muted_flag "$id")" -eq 0 ]] && { any_active=1; break; }
      fi
    done
  fi
  $VERBOSE && echo "Toggle => $([[ $any_active -eq 1 ]] && echo 'cut' || echo 'restore')."
  (( any_active )) && CUT=true || CUT=false
fi

# 4) Apply (always run both loops, one cannot block the other)
apply_cmd(){ $VERBOSE && echo "CMD: $*"; $DRYRUN || "$@"; }

if [[ "$ACTION" == "on" || ( "$ACTION" == "toggle" && "$CUT" = true ) ]]; then
  for id in "${OUT_IDS[@]}"; do apply_cmd wpctl set-volume "$id" 0%; done
  for id in "${IN_IDS[@]}";  do
    if $INPUT_VOLUME; then apply_cmd wpctl set-volume "$id" 0%
    else                   apply_cmd wpctl set-mute   "$id" 1
    fi
  done
else # off OR toggle restore
  for id in "${OUT_IDS[@]}"; do apply_cmd wpctl set-volume "$id" 100%; done
  for id in "${IN_IDS[@]}";  do
    if $INPUT_VOLUME; then apply_cmd wpctl set-volume "$id" 100%
    else                   apply_cmd wpctl set-mute   "$id" 0
    fi
  done
fi
