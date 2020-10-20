{
  stdenv, fetchFromGitHub, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "heliocron";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mfreeborn";
    repo = pname;
    rev = "v${version}";
    sha256 = "1v0p7z9w1ff557f1ca038m41dhslxm0limnp94pfw6c0fr02qvb6";
  };

  cargoSha256 = "15dnw90n478rwsgsa6j9z6fxv8i309ay3c6qwplhxz0fx47xfyj8";

  meta = with stdenv.lib; {
    description = "A command line application capable of delaying execution of other programs for time periods relative to sunrise and sunset";
    homepage = "https://github.com/mfreeborn/heliocron";
    license = with licenses; [ apache2 mit ];
  };
}

