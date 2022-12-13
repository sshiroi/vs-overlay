{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-deinterlace";
  #version = "0.5.1";
  version = "unstable-2022-12-13";
  importname = "vsdeinterlace";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "8655c8b8e4988e8f81eaf99326260670fa386cca";
    sha256 = "sha256-I08F/7ey/6Ku2VJ8K/FoRSUO4sP/AbX96Nc6wNaNanE=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [
    vs-tools
    vs-kernels
    vs-rgtools
  ];
  vs_binarydeps = with vapoursynthPlugins; [
    planestatsmod
  ];

  remove_vapoursynth_dep_reqtxt = 59;

  meta = with lib; {
    description = "Tools and functions to manage, create, and manipulate masks in VapourSynth.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsmask";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
