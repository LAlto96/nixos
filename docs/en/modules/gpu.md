# GPU

- `amdgpu.nix`: AMD driver stack + Vulkan/ROCm components.
- `nvidiagpu.nix`: NVIDIA stack with open kernel module and beta package selection.

## Discord Canary NVENC

The `desktop` host installs Discord Canary with Vencord through `packages/common.nix`.
That package is wrapped so Discord starts with `/run/opengl-driver/lib` in
`LD_LIBRARY_PATH`, exposing the NVIDIA libraries needed by the screen-sharing
patch.

The Discord Canary package is also patched at Nix build time, directly against
the `index.js` shipped by the current packaged Discord Canary version. The
configuration does not copy the full upstream patcher `index.js`, because that
file may target a different Discord client version.

The contextual patch applies only the behavior observed in
`relativemodder/discord-linux-vulkan-video-patcher`:

- `setTransportOptions` removes `vaapi` from video experiments and adds
  `linux-nvenc` + `useCaptureDeviceForEncode` on Linux;
- `setDesktopSourceWithOptions` forces `useCaptureDeviceForEncode = true` on
  Linux;
- `createVoiceConnectionWithOptions` adds `linux-vulkan` to connection
  experiments on Linux.

Each replacement is strict: if the expected anchor is missing or appears more
than once, the build fails. In that case, inspect the new packaged
`discord_voice/index.js` and adjust the minimal patch anchors instead of copying
a complete upstream file.

`gpu_encoder_helper` and `discord_voice.node` remain executable. There is no user
service and nothing automatically mutates `~/.config/discordcanary`.

### Migrating from the old user service

If the old `discord-nvenc-patch` service already ran, it may have replaced the
`~/.config/discordcanary/*/modules/discord_voice` symlink with a local copy. In
that case, remove the local Discord Canary version directory after rebuilding so
Discord recreates it from the patched Nix package:

```sh
rm -rf ~/.config/discordcanary/1.0.1095
```

Adjust the version number if Discord Canary has changed.
