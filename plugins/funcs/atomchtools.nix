{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "VapourSynth-atomchtools";
  version = "unstable-2022-12-05";
  importname = "atomchtools";

  src = fetchFromGitHub {
    owner = "DJATOM";
    repo = pname;
    rev = "34e16238291954206b3f7d5b704324dd6885b224";
    sha256 = "sha256-etGeflv1klpPQmNafrXqMBVgyODOfG7DE3HciWqckYI=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    nnedi3
    nnedi3cl
    znedi3
    tivtc
    bm3d
    tcanny
    retinex
    #rfmod cant'find
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    descale#todo:
    havsfunc
    cooldegrain
  ];

  meta = with lib; {
    description = "DJATOM";
    homepage = "https://github.com/DJATOM/VapourSynth-atomchtools";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
