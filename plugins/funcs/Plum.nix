{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "Plum";
  version = "unstable-2022-12-11";
  importname = "Plum";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "647f53a80c4fc2cf26f1d9a56c6c2031554f46d8";
    sha256 = "sha256-Cs+Tp9d5N5vwbPyL4tl92yISCUZs0j2yjFNY3JwRcVc=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    nnedi3
    knlmeanscl
    bm3d
    fmtconv
    vcm
    mvtools-sf
  ];

  vs_pythondeps = [];

  meta = with lib; {
    description = "sharpening/blind deconvolution suite";
    homepage = "https://github.com/IFeelBloated/Plum";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}