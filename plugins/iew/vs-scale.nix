{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-scale";
  version = "git-unstable";
  importname = "vsscale";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "46fef8316d444f044c885ea39286fe0f0175639c";
    sha256 = "sha256-jUYxrt69iBZcDGWnWABv871uWIaMBgquUrJCZNcUzio=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vsmask
  ];
  vs_binarydeps = [];

  meta = with lib; {
    description = "Wrappers for scaling and descaling functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-scale";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
