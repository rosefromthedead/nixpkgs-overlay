self: super:

{
  sierraBreeze = super.callPackage ./sierra-breeze.nix {};
  plasmaThemeSwitcher = super.callPackage ./plasma-theme-switcher/default.nix {};
  heliocron = super.callPackage ./heliocron.nix {};
  openjdk7 = super.callPackage ./openjdk7/default.nix {};
}
