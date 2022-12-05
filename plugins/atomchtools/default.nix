{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    nnedi3
    nnedi3cl
    znedi3
    tivtc
    bm3d

    tcanny
    retinex

    #rfmod
    #cant'find
  ];
in
buildPythonPackage rec {
  pname = "VapourSynth-atomchtools";
  version = "unstable-2022-12-05";

  src = fetchFromGitHub {
    owner = "DJATOM";
    repo = pname;
    rev = "34e16238291954206b3f7d5b704324dd6885b224";
    sha256 = "sha256-etGeflv1klpPQmNafrXqMBVgyODOfG7DE3HciWqckYI=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    descale
    havsfunc
    cooldegrain
  ] ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D atomchtools.py $out/${python.sitePackages}/atomchtools.py
  '';

  checkInputs = [ (vapoursynth.withPlugins (propagatedBinaryPlugins )) ];
  #shitty workaround
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "atomchtools" ];

  meta = with lib; {
    description = "DJATOM";
    homepage = "https://github.com/DJATOM/VapourSynth-atomchtools";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
