{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-fieldhint";
  version = "3";
  namespace = "fh";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-c0/59NQDINM1WnkcUMB6ItxgRA+OV5dEn6BxFG7UQmg=";
  };

  meta = with lib; {
    description = "FieldHint creates new frames by copying the top and bottom fields from arbitrary frames chosen by the user.";
    homepage = "https://github.com/dubhater/vapoursynth-fieldhint";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}