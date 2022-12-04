{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    bilateral
    descale
    dfttest
    fmtconv
    nnedi3
  ];
in
buildPythonPackage rec {
  pname = "fvsfunc";
  version = "unstable-2022-11-27";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "076dbde68227f6cca91304a447b2a02b0e95413e";
    sha256 = "sha256-i6ONBdPIi3h4NxfVi4ggvuiElKn0S8uao5BVT+F9sMQ=";
  };

  propagatedBuildInputs = (with vapoursynthPlugins; [
    havsfunc
    muvsfunc
    mvsfunc
    nnedi3_rpow2
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D fvsfunc.py $out/${python.sitePackages}/fvsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "fvsfunc" ];

  meta = with lib; {
    description = "A small collection of VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/fvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
