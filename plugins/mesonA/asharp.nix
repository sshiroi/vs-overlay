{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-asharp";
  version = "1";
  namespace = "asharp";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-mxeJ+7qFbjgWTE/bC+Ue0Q4EdfTvVoU9X739kgj1TVQ=";
  };

  meta = with lib; {
    description = "adaptive sharpening filter";
    homepage = "https://github.com/dubhater/vapoursynth-asharp";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
