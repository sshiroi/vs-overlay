{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-aa";
  version = "unstable-2022-11-26";
  importname = "vsaa";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "fca442a0f348a0202d7eb45f666fd64ecbf6cf49";
    sha256 = "sha256-YGNvwZcXnLM+5e34RIz092TQsM7Ch1Jr9HQekqb9eGM=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vsmask
    vs-kernels
    vs-exprtools
    vs-rgtools
  ];

  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 59;

  meta = with lib; {
    description = "anti aliasing and scaling functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-aa";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
