{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-DeblockPP7";
  version = "4.1";
  namespace = "pp7";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-3dGg7vTidCNpjTAocM85S0wg74nkogR1yjepbznQpJo=";
  };

  meta = with lib; {
    description = "Variant of the spp filter in MPlayer, similar to spp=6 with 7 point DCT where only the center sample is used after IDCT.";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeblockPP7";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
