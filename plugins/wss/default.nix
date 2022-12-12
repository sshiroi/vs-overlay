{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

buildPythonPackage rec {
  pname = "WarpSharpSupport";
  version = "1";

  src = fetchFromGitHub {
    owner = "myrsloik";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-3g/dlRKvtBiICsVIfco5lkYiIFB+VIoQhZ9jFmxq2U4=";
  };

  format = "other";

  installPhase = ''
    install -D wss.py $out/${python.sitePackages}/wss.py
  '';

  checkInputs = [ (vapoursynth.withPlugins []) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "wss" ];

  meta = with lib; {
    description = "Script versions of support functions from WarpSharp";
    homepage = "https://github.com/myrsloik/WarpSharpSupport/";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
