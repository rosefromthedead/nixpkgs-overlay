{
  stdenv, fetchurl,
  extra-cmake-modules, unzip,
  kdeFrameworks, plasma5, qt5
}:

stdenv.mkDerivation {
  pname = "sierraBreeze";
  version = "0.1";

  src = fetchurl {
    url = "https://github.com/ishovkun/SierraBreeze/archive/0e132fa46871283265c4f0e22e7bb04d8ee7553e.zip";
    sha256 = "26da20655d4a5d87aba0ec03346cf49845b1401fead49355496d0a29ca470a5b";
  };

  nativeBuildInputs = [ extra-cmake-modules unzip ];
  propagatedBuildInputs = with kdeFrameworks; [
    frameworkintegration kcmutils kcompletion kconfig plasma5.kdecoration kguiaddons
    ki18n kservice kwayland kwidgetsaddons kwindowsystem qt5.qtdeclarative
    qt5.qtx11extras
  ];
  outputs = [ "bin" "dev" "out" ];

  meta = with stdenv.lib; {
    description = "A MacOS-like Aurorae theme";
    longDescription = ''
      Sierra Breeze is a fork of Breeze Window decoration that aims to mimic the OSX Sierra titlebar buttons.
    '';
    homepage = "https://github.com/ishovkun/SierraBreeze";
    platforms = platforms.all;
  };
}

