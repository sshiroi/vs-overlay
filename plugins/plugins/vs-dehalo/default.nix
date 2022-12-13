{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
buildPythonPackage rec {
  pname = "vs-dehalo";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "1415d481fbcf4e2d0fa1b3774984577b4cd0801d";
    sha256 = "sha256-7eRneoY2+jIjzB7mo4bYpIyKlwhjA+ztjVWW8GgJhRg=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vsmask
    vs-aa
    vs-scale
    vs-denoise
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=60" ""
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  checkInputs = [ (vapoursynth.withPlugins [  ]) ];
  pythonImportsCheck = [ "vsdehalo" ];


  meta = with lib; {
    description = "Collection of dehaloing VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dehalo";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
