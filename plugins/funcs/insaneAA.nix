{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "VapourSynth-insaneAA";
  version = "0.91";
  importname = "insaneAA";

  src = fetchFromGitHub {
    owner = "Beatrice-Raws";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-oHUtipOlNvZJK9RZZT8o71Ck6yUrNshX8if4MHA4dXo=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    eedi3m
    #eedi3cl
    nnedi3
    znedi3
    nnedi3cl
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    descale
    finedehalo
  ];

  meta = with lib; {
    description = "InsaneAA Anti-Aliasing Script";
    homepage = "https://github.com/Beatrice-Raws/VapourSynth-insaneAA";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
