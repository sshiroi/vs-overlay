{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-ssiq";
  version = "1.0";
  namespace = "ssiq";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-IjNBcaHpHFL74EbDbQefXOOfpCMO6iGqGJ8fVwv2Trk=";
  };

  meta = with lib; {
    description = "this filter performs structure-preserving smoothing";
    homepage = "https://github.com/dubhater/vapoursynth-ssiq";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
