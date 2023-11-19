{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich }:

mkVapoursynthPythonSetuptools rec {
  pname = "stgpytools";
  version = "git-unstable";
  importname = "stgpytools";

  src = fetchFromGitHub {
    owner = "Setsugennoao";
    repo = pname;
    rev = "7abe43c0de02570ec4a6ee2190798aa78e07bb9b";
    sha256 = "sha256-LITyt/akdExvldp/j3Y28QkturuXCZ5XaJm3v02m6F4=";
  };

  vs_pythondeps =  [  ];
  vs_binarydeps = [];

  propagatedBuildInputs = [ ];



  meta = with lib; {
    description = "collection of functions, utils, types, type-utils, and more aimed at helping at having a common ground between VapourSynth packages";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-tools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
