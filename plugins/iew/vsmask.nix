{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vsmask";
  #version = "0.5.1";
  version = "unstable-2022-12-13";
  importname = "vsmask";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "3cd8ca706bce7915fa850d43b0b16c94af42bf6d";
    sha256 = "sha256-Y+/fEer6CjEHNfDN0QD6PFg3pygx/ZgFUGy14kowzTY=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [ vsutil ];
  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "Tools and functions to manage, create, and manipulate masks in VapourSynth.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsmask";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
