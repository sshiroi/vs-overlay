{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-colorbars";
  version = "unstable-2022-11-24";
  namespace = "colorbars";

  src = fetchFromGitHub {
    owner = "ifb";
    repo = pname;
    rev = "73a8b4033b8ecdf892fba3f66b4b63ec7a825181";
    sha256 = "sha256-pHj5naHdAY0HEMseI3WL7VpXATVWqd96YPUqlYtg6Nc=";
  };

  meta = with lib; {
    description = "Filter for generating test signals";
    homepage = "https://github.com/ifb/vapoursynth-colorbars";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
