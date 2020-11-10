self: super:

{
  sierraBreeze = super.callPackage ./sierra-breeze.nix {};
  plasmaThemeSwitcher = super.callPackage ./plasma-theme-switcher/default.nix {};
  heliocron = super.callPackage ./heliocron.nix {};
  openjdk7 = super.callPackage ./openjdk7/default.nix {};
  multimc-fixed = super.multimc.overrideAttrs (oldAttrs: {
    # Don't change the data directory from sane default to ~/.multimc
    # I have no idea why nixpkgs does this in the first place
    postInstall = builtins.replaceStrings [''--add-flags "-d \$HOME/.multimc/" ''] [""] oldAttrs.postInstall;
  });
  nvidia-offload = super.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
  cuda-run = super.writeShellScriptBin "cuda-run" ''
    export LD_LIBRARY_PATH=${self.linuxPackages.nvidia_x11}/lib/
    exec -a "$0" "$@"
  '';
}
