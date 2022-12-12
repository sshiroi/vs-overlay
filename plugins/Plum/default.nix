{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

buildPythonPackage rec {
  pname = "Plum";
  version = "unstable-2022-12-11";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "647f53a80c4fc2cf26f1d9a56c6c2031554f46d8";
    sha256 = "sha256-Cs+Tp9d5N5vwbPyL4tl92yISCUZs0j2yjFNY3JwRcVc=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    nnedi3
    knlmeanscl
    bm3d
    fmtconv
    vcm
    mvtools-sf
  ];

  format = "other";

  installPhase = ''
    install -D Plum.py $out/${python.sitePackages}/Plum.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "Plum" ];

  meta = with lib; {
    description = "sharpening/blind deconvolution suite";
    homepage = "https://github.com/IFeelBloated/Plum";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
