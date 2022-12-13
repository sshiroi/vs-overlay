{ lib, vapoursynthPlugins, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "Oyster";
  version = "unstable-2022-11-24";
  importname = "Oyster";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "a8e5749ba7a3c34bc7e568a02cf58d70753230b3";
    sha256 = "sha256-yLJ45xn7i8ED3Lse+bMHCB6oKc7l3fIJFM6kncmiuhE=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    nnedi3
    knlmeanscl
    bm3d
    dfttest
    fmtconv
    mvtools-sf
  ];

  vs_pythondeps = [];

  meta = with lib; {
    description = "A experimental implement of the Blocking Matching concept, designed specifically for compression artifacts removal.";
    homepage = "https://github.com/IFeelBloated/Oyster";
    license = licenses.lgpl3; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
