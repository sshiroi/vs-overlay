{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-motionmask";
  version = "unstable-2021-07-20";
  namespace = "motionmask";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "ed86b06688c2db1b05d7026f66a2574e64c9e69e";
    sha256 = "sha256-wYb3L8aETt4FfpWugiOHMmgBSLN0Xuo1vxkQLULQUoE=";
  };

  meta = with lib; {
    description = "MotionMask plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-motionmask";
    license = licenses.mit;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
