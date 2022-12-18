{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins, python3 }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "xvs-func";
  version = "unstable-2022-12-05";
  importname = "xvs";

  src = fetchFromGitHub {
    owner = "xyx98";
    repo = "my-vapoursynth-script";
    rev = "b24d5594206635f7373838acb80643d2ab141222";
    sha256 = "sha256-aR20FF8qDuGKKwQhspULtyr2MnXdaOKGX0D9YT7+Ehg=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    removegrain
    mvtools
    fluxsmooth
    fmtconv
    awarpsharp2
    tcanny
    f3kdb
    tdeintmod
    nnedi3cl
    #svp1
    #svp2
    dpid
    tonemap
    readmpls
    #lsmas ( not adding because you should be able to choose what version)
    #akarin ( not adding because this fucks with llvm stuff)
    vivtc
    tivtc
    bm3d
    cas
    subtext
    #bm3dcpu ? bm3dcuda bm3dcuda_rtc

    #descale (in python)

    #vsfiltermod
    #vsfilter
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    muvsfunc
    havsfunc

    descale
  ];

  meta = with lib; {
    description = "nothing";
    homepage = "https://github.com/xyx98/my-vapoursynth-script";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
