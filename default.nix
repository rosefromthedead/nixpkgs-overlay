self: super:

{
  sierraBreeze = super.callPackage ./sierra-breeze/default.nix {};
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
    export CUDA_PATH=${self.cudaPackages.cudatoolkit_11}/
    exec -a "$0" "$@"
  '';
  starship-fixed = super.starship.overrideAttrs (oldAttrs: {
    features = [ "notify-rust" ];
  });
  libinput-gestures-not-ancient = super.libinput-gestures.overrideAttrs (oldAttrs: rec {
    version = "2.62";
    pname = "libinput-gestures-not-ancient";
    src = self.fetchFromGitHub {
      owner = "bulletmark";
      repo = "libinput-gestures";
      rev = version;
      sha256 = "JCgxQ8oBHUSSdIs8sBBPviuR777Hw6mjtiHffnmpAOQ=";
    };
    patches = [ ./0002-paths.patch ];
  });
}
