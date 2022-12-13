{ lib,  fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "vivtc";
  version = "unstable-2021-09-26";
  namespace = "vivtc";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "ed56d96d13a2989fc147a1e9faaced959b6b2cd8";
    sha256 = "sha256-4tevOjXy41yWYIvsvNODVzVlNx5e/Yf1zFK20Q/8RGs=";
  };

  meta = with lib; {
    description = "Field matcher and decimation filter for VapourSynth similar to TIVTC";
    homepage = "https://github.com/vapoursynth/vivtc";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
