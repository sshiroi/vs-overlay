{ lib, vapoursynthPlugins, mkVapoursynthPythonSinglefileFunc, fetchpatch, fetchFromGitHub }:

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


  patches = [
    (fetchpatch {
      url = "https://github.com/IFeelBloated/Oyster/commit/1981dec88262df608fc4caf3b4d42b8a566af98b.patch";
      sha256 = "sha256-uGYj8J3uo74yfHZUtxCfOrTp8wr+ntj5NgJpAi76rQs=";
    })
  ];

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
