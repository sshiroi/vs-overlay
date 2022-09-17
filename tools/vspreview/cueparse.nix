{ lib, buildPythonPackage, fetchFromGitHub }:
buildPythonPackage rec {
  pname = "cueparse";
  #there is no release
  version = "unstable-2022-09-08";

  src = fetchFromGitHub {
    owner = "artur-shaik";
    repo = "CueParser";
    rev = "4d9ffb1d19ec0164aeaebaf85b405304e03e803f";
    sha256 = "sha256-KyCpev+Kv0SqxKvQ63GV7qDS0kwCq790G2dXfr/sLvc=";
  };
  meta = with lib; {
    description = "Simple cue file parser written in python. Outputs cue file content in plain text. Can be used as a library.";
    homepage = "https://github.com/artur-shaik/CueParser";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}