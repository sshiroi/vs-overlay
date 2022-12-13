{ lib, vapoursynthPlugins, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, matplotlib, python, vapoursynth }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "muvsfunc";
  version = "unstable-2022-11-28";
  importname = "muvsfunc";

  src = fetchFromGitHub {
    owner = "WolframRhodium";
    repo = pname;
    rev = "428c42f2137c2b51a20ceb2438b61d7b011cc9ba";
    sha256 = "sha256-MOKyNzUBrwuRkcKtW5KxphmpXJgdWBpMRiFUtqsFOMI=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    descale
    histogram
    median
    tcanny
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    havsfunc
    mt_lutspa
    mvsfunc
    nnedi3_resample
  ];

  propagatedBuildInputs = [
    matplotlib
  ];

  meta = with lib; {
    description = "Muonium’s VapourSynth functions";
    homepage = "https://github.com/WolframRhodium/muvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
