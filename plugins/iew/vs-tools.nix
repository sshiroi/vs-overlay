{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-tools";
  version = "git-unstable";
  importname = "vstools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "025932e7f407acf1ef0084faf7dc078d5edeb2ae";
    sha256 = "wgRJqrWZds7NTsbcCCiw29gxuVb431aT5m8EV4wiIXc=";
  };

  vs_pythondeps =  with vapoursynthPlugins; [ vsutil ];
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
