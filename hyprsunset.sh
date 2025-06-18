#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="$HOME/hyprsunset.log"

log() {
  printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG_FILE"
}

log "Starting hyprsunset"

# Coordinates for Bouc-Bel-Air
LAT=43.452
LON=5.413
TIMEZONE="Europe/Paris"

INTERVAL=300  # check every 5 minutes
API="https://api.sunrisesunset.io/json?lat=$LAT&lng=$LON&date=today&timezone=$TIMEZONE"

fetch_times() {
  local data
  if ! data=$(curl -sf "$API"); then
    log "Failed to query sunrise/sunset"
    return 1
  fi
  sunrise=$(echo "$data" | jq -r '.results.sunrise')
  sunset=$(echo "$data" | jq -r '.results.sunset')
  sunrise_unix=$(TZ="$TIMEZONE" date -d "$sunrise" +%s)
  sunset_unix=$(TZ="$TIMEZONE" date -d "$sunset" +%s)
  log "Sunrise: $sunrise ($sunrise_unix), Sunset: $sunset ($sunset_unix)"
}

get_temp() {
  journalctl --user -u hyprsunset.service -n 20 --no-pager |
    awk '/Received a request:/ { t=$NF } END { if (t) print t }'
}

set_temp() {
  log "Setting temperature to $1"
  if [[ "$1" == "identity" ]]; then
    hyprctl hyprsunset identity
  else
    hyprctl hyprsunset temperature "$1"
  fi
}

manual_override=false
prev_temp=""

while true; do
  if ! fetch_times; then
    echo "Failed to query sunrise/sunset" >&2
    sleep "$INTERVAL"
    continue
  fi

  now=$(date +%s)
  current_temp=$(get_temp)

  if (( now >= sunset_unix || now < sunrise_unix )); then
    log "Nighttime - current temp: ${current_temp:-none}"
    if $manual_override; then
      if [[ "$current_temp" != "identity" ]]; then
        log "Manual override ended"
        manual_override=false
      else
        prev_temp="$current_temp"
        sleep "$INTERVAL"
        continue
      fi
    else
      if [[ "$prev_temp" == "4000" && "$current_temp" == "identity" ]]; then
        log "Manual temperature override detected"
        manual_override=true
        prev_temp="$current_temp"
        sleep "$INTERVAL"
        continue
      fi
    fi

    if [[ -z "$current_temp" || "$current_temp" != "4000" ]]; then
      set_temp 4000
      current_temp=$(get_temp)
    fi
  else
    log "Daytime - current temp: ${current_temp:-none}"
    manual_override=false
    if [[ -z "$current_temp" || "$current_temp" != "identity" ]]; then
      set_temp identity
      current_temp=$(get_temp)
    fi
  fi
  prev_temp="$current_temp"
  sleep "$INTERVAL"
done
