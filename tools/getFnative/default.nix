{ lib, vapoursynth,mkVapoursynthPythonSinglefileFunc, vapoursynthPlugins, buildPythonApplication, fetchFromGitHub, matplotlib, imagemagick }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "getFnative";
  version = "unstable-2023-02-21";
  importname = "getfnative";

  src = fetchFromGitHub {
    owner = "YomikoR";
    repo = pname;
    rev = "009a8594a4a0fe343b2278d6922750e61a7833f2";
    sha256 = "sha256-Ky792NsMsH53gOvQC56SMkvwQPSWGOBfTtDnGhK9b/o=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    descale
  ];
  vs_binarydeps = [];

  propagatedBuildInputs = [
    matplotlib
  ];

  meta = with lib; {
    description = "A script that help find the native fractional resolution of upscaled material (mostly anime)";
    homepage = "https://github.com/YomikoR/GetFnative";
    license = licenses.lgpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
