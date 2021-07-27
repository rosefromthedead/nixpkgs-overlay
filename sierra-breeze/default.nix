{
  stdenv, fetchFromGitHub,
  extra-cmake-modules, unzip,
  libsForQt5
}:

stdenv.mkDerivation {
  pname = "sierraBreeze";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "ishovkun";
    repo = "SierraBreeze";
    rev = "0e132fa46871283265c4f0e22e7bb04d8ee7553e";
    sha256 = "0z7srdkm6gjq1lmxjhh22x3p2l72cs3n51lzwxyqq0l7nzx5gg91";
  };

  patches = [ ./include-more-headers.patch ];

  nativeBuildInputs = [ extra-cmake-modules unzip ];
  propagatedBuildInputs = with libsForQt5; [
    frameworkintegration kcmutils kconfigwidgets kcoreaddons kdecoration
    kguiaddons ki18n kwayland kwindowsystem plasma-framework qtdeclarative
    qtx11extras
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

