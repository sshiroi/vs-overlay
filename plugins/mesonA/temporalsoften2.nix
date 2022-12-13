{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA, fetchpatch }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-temporalsoften2";
  version = "1";
  namespace = "focus2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-mBRQ6cIdQgXsy0lhvUBZ6XUa1MVlJDAT6XZ72mbamZ4=";
  };

  patches = [
    # security
    (fetchpatch {
      url = "https://github.com/dubhater/vapoursynth-temporalsoften2/commit/a133670676a311dde31b0eb1a771bbd94ffb1235.diff";
      sha256 = "sha256-xyAl4aWfLYKdcC/Z5zJUaC6HNewOFDqV6j8J8fSlrkY=";
    })
  ];
  
  meta = with lib; {
    description = "TemporalSoften filter for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-temporalsoften2";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
