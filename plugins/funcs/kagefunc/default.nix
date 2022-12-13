{ lib, vapoursynthPlugins, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, python, vapoursynth }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "kagefunc";
  version = "0.1.0";
  #bump to unstable 96947a1bda5639a4e0b89202e964a15bc337521d maybe ?
  importname = "kagefunc";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "sha256-9OpFSVLQspa6+xkCFqD5xeo3akCfwnpwtFuCCsQxAvQ=";
  };

  patches = [
    ./skip-opencl-test.diff
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    adaptivegrain
    addgrain
    bm3d
    descale
    fmtconv
    knlmeanscl
    retinex
    tcanny
    wwxd
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    fvsfunc
    mvsfunc
    vsutil
  ];

  checkPhase = ''
    python3 tests.py
  '';
  
  meta = with lib; {
    description = "A collection of Vapoursynth functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/kagefunc";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}