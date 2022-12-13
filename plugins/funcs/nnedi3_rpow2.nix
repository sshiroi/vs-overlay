{ lib, mkVapoursynthPythonSinglefileFunc, fetchgit, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "nnedi3_rpow2";
  version = "1.1.0";
  importname = "nnedi3_rpow2";

  src = fetchgit {
    url = "https://gist.github.com/4re/342624c9e1a144a696c6";
    rev = "68ec4bdff1e51a3832b163198ed7ea00e1c1ab46";
    sha256 = "0i112kqkrlinnkkx4rjfmzpzax07mn8gxh2bnf13ccjpbpxigrnn";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    fmtconv
    nnedi3
    nnedi3cl
    znedi3
  ];

  vs_pythondeps = [];

  meta = with lib; {
    description = "A vapoursynth plugin for enlarging images by powers of 2";
    homepage = "https://gist.github.com/4re/342624c9e1a144a696c6";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
