{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-tools";
  #version = "1.6.7";
  version = "unstable-2022-12-10";
  importname = "vstools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "28a15b8e30a0844fdbac6d9173fe02339a8bb7d5";
    sha256 = "sha256-tuEX7yFrk4qNnXjIPSn3JQv+FYNA0eg+6he8vVFb748=";
  };

  vs_pythondeps =  with vapoursynthPlugins; [ vsutil ];
  vs_binarydeps = [];

  propagatedBuildInputs = [ rich ];

  remove_vapoursynth_dep_reqtxt = 59;

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
