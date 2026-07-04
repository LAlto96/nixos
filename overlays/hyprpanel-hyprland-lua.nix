final: prev: {
  hyprpanel = prev.hyprpanel.overrideAttrs (oldAttrs: {
    postPatch = (oldAttrs.postPatch or "") + ''
      substituteInPlace src/components/bar/modules/workspaces/workspaces.tsx \
        --replace-fail \
          "hyprlandService.dispatch('workspace', wsId.toString());" \
          "hyprlandService.message('dispatch hl.dsp.focus({ workspace = ' + wsId.toString() + ' })');"

      substituteInPlace src/services/workspace/index.ts \
        --replace-fail \
          "hyprlandService.dispatch('workspace', targetWorkspaceNumber.toString());" \
          "hyprlandService.message('dispatch hl.dsp.focus({ workspace = ' + targetWorkspaceNumber.toString() + ' })');"
    '';
  });
}
