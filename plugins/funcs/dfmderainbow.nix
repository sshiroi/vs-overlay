{ lib, fetchFromGitHub, mkVapoursynthPythonSinglefileFunc,  vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "vapoursynth-dfmderainbow";
  version = "unstable-2022-12-12";
  importname = "dfmderainbow";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "44dc6545bced8fc25672bdda717943a02c6b5d71";
    sha256 = "sha256-0+DnuQKLaO4AHSK7o0LRpYI1oaYVe8qVgfq1K555afI=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    minideen
    msmoosh
    mvtools
    temporalmedian
    temporalsoften2
  ];
  vs_pythondeps = [];

  meta = with lib; {
    description = "DFMDerainbow is a derainbow function for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-dfmderainbow";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}