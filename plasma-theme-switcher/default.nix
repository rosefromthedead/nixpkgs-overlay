{
  stdenv, fetchurl,
  extra-cmake-modules, kdeFrameworks, qt5, unzip
}:

stdenv.mkDerivation {
  pname = "plasmaThemeSwitcher";
  version = "0.1";

  src = fetchurl {
    url = "https://github.com/maldoinc/plasma-theme-switcher/archive/ccc595f126a58475b42a6013727c6d0a9943b6e1.zip";
    sha256 = "0lx3vwgghmppz7nbwlsbr6xqzasf407p5zrm1dli8773b5rf43p3";
  };

  patches = [ ./install.patch ];

  nativeBuildInputs = [ extra-cmake-modules kdeFrameworks.kconfig qt5.qtbase unzip ];

  meta = with stdenv.lib; {
    description = "Command-line tool to change the current Plasma theme";
    homepage = "https://github.com/maldoinc/plasma-theme-switcher";
    platforms = platforms.all;
  };
}

