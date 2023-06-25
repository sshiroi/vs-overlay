{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-dehalo";
  version = "git-1.7.1";
  importname = "vsdehalo";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "4aecdb127a5327a86e220352718ec084b95a5097";
    sha256 = "sha256-iL3vjotyiq48u2VkHI5I7Ess5dBqNOZr5p3szw/guNQ=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vsmask
    vs-aa
    vs-scale
    vs-denoise
  ];

  vs_binarydeps = [ ];

  remove_vapoursynth_dep_reqtxt = 60;
  
  doCheck = false;

  meta = with lib; {
    description = "Collection of dehaloing VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dehalo";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
