{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, matplotlib, python, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    histogram
    median
    tcanny
  ];
in
buildPythonPackage rec {
  pname = "muvsfunc";
  version = "unstable-2022-11-28";

  src = fetchFromGitHub {
    owner = "WolframRhodium";
    repo = pname;
    rev = "428c42f2137c2b51a20ceb2438b61d7b011cc9ba";
    sha256 = "sha256-MOKyNzUBrwuRkcKtW5KxphmpXJgdWBpMRiFUtqsFOMI=";
  };

  propagatedBuildInputs = [
    matplotlib
  ] ++ (with vapoursynthPlugins; [
    havsfunc
    mt_lutspa
    mvsfunc
    nnedi3_resample
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D muvsfunc.py $out/${python.sitePackages}/muvsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "muvsfunc" ];

  meta = with lib; {
    description = "Muonium’s VapourSynth functions";
    homepage = "https://github.com/WolframRhodium/muvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
