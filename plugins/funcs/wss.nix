{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "WarpSharpSupport";
  version = "1";
  importname = "wss";

  src = fetchFromGitHub {
    owner = "myrsloik";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-3g/dlRKvtBiICsVIfco5lkYiIFB+VIoQhZ9jFmxq2U4=";
  };

  vs_binarydeps = [];
  vs_pythondeps = [];

  meta = with lib; {
    description = "Script versions of support functions from WarpSharp";
    homepage = "https://github.com/myrsloik/WarpSharpSupport/";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
