{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-pyplugin";
  version = "git-1.3.2";
  importname = "vspyplugin";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "890feeb0f75bf2dfcc214df377230e877ca9e138";
    sha256 = "sha256-uFo8dk4fPyGq3YFCfw/BoPMe1IFJDW8liVrn641C4h0=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [ vs-tools ];
  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "Package for simplifying writing VapourSynth plugins in python.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-pyplugin";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
