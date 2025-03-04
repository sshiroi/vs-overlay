{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-tools";
  version = "git-unstable";
  importname = "vstools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "22e39df6b89fb07909c83e41c97d57e73f0c13d5";
    sha256 = "sha256-/BslVqIUAB14h8HM5S0TEuZKG1Rymh9EVrAJ+pEqeCY=";
  };

  vs_pythondeps =  with vapoursynthPlugins; [ vsutil stgpytools ];
  vs_binarydeps = [];

  propagatedBuildInputs = [ rich ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "rich>=12.6.0" "rich>=12.4.1"
  '';


  meta = with lib; {
    description = "collection of functions, utils, types, type-utils, and more aimed at helping at having a common ground between VapourSynth packages";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-tools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
