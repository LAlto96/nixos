# GPU

## `amdgpu.nix`

- Charge `amdgpu` en initrd.
- Définit `services.xserver.videoDrivers = [ "amdgpu" ]`.
- Active la stack graphics 32 bits.
- Ajoute des composants Vulkan/ROCm.

## `nvidiagpu.nix`

- Active `cudaSupport`.
- Définit `services.xserver.videoDrivers = [ "nvidia" ]`.
- `hardware.nvidia.open = true`.
- Pilote choisi: `config.boot.kernelPackages.nvidiaPackages.beta`.

## Remarque

Le host `laptop` importe `amdgpu.nix`, le host `desktop` importe `nvidiagpu.nix`.
