{ mkVapoursynthPythonSinglefileFunc, lib, vapoursynthPlugins, fetchFromGitHub }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "fvsfunc";
  version = "unstable-2022-11-27";
  importname = "fvsfunc";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "076dbde68227f6cca91304a447b2a02b0e95413e";
    sha256 = "sha256-i6ONBdPIi3h4NxfVi4ggvuiElKn0S8uao5BVT+F9sMQ=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    havsfunc
    muvsfunc
    mvsfunc
    nnedi3_rpow2
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    bilateral
    descale
    dfttest
    fmtconv
    nnedi3
  ];

  meta = with lib; {
    description = "A small collection of VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/fvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
