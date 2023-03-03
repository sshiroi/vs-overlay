{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "Vapoursynth-BalanceBorders";
  version = "unstable-2023-01-01";
  importname = "BalanceBorders";

  src = fetchFromGitHub {
    owner = "fdar0536";
    repo = pname;
    rev = "491d6521bfe8c99457841aaa5dabc0acfda37791";
    sha256 = "sha256-Mjdr0Q44RV17g2upenbEHXMT3CCLwV2tCg9SpBgpMco=";
  };

  postPatch = ''
    substituteInPlace BalanceBorders.py --replace "core = vs.get_core()" "core = vs.core"
  '';

  vs_binarydeps = [ ];

  vs_pythondeps = [ ];

  meta = with lib; {
    description = "Vapoursynth-BalanceBorders";
    homepage = "https://github.com/fdar0536/Vapoursynth-BalanceBorders";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
