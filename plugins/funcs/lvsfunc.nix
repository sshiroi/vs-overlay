{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich, toolz, pymediainfo, vapoursynth, pythonOlder, fetchPypi }:

mkVapoursynthPythonSetuptools rec {
  pname = "lvsfunc";
  version = "unstable";
  importname = "lvsfunc";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "83be576606f934eff979705b497a0ddea74eabd2";
    sha256 = "sha256-L3ixQAmDzFcbZSTUaXJ8hfMszgN77EaK5OK+no3L7PI=";
  };

  propagatedBuildInputs = [
    rich
    toolz
    pymediainfo
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    vs-deband
    edi_rpow2
    havsfunc
    kagefunc
    mvsfunc
    vsTAAmbk
    vsutil
    vs-scale
    vs-parsedvd
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    adaptivegrain
    combmask
    continuityfixer
    d2vsource
    descale
    eedi3m
    fmtconv
    knlmeanscl
    nnedi3
    readmpls
    retinex
    rgsf
    removegrain
    tcanny
    znedi3
  ];

  meta = with lib; {
    description = "A collection of LightArrowsEXE’s VapourSynth functions and wrappers";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/lvsfunc";
    license = licenses.mit; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
    broken = pythonOlder "3.10";
  };
}
