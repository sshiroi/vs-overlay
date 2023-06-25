{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-tools";
  version = "git-2.0.0";
  importname = "vstools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "5c8d8dfa987008503316b0bb7507314fb4f73fd2";
    sha256 = "sha256-xXSU1Gcy3yCxUxbDWl5ObK3HGLOa3slvTd4OJOIRfP8=";
  };

  vs_pythondeps =  with vapoursynthPlugins; [ vsutil ];
  vs_binarydeps = [];

  propagatedBuildInputs = [ rich ];

  remove_vapoursynth_dep_reqtxt = 60;

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
