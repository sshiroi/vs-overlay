{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, matplotlib, python, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "zzfunc";
  version = "unstable-2022-09-17";
  importname = "zzfunc";

  src = fetchFromGitHub {
    owner = "kgrabs";
    repo = pname;
    rev = "febe2665d9c7c1689398ef9200578a32992e2921";
    sha256 = "rXz99dDk6UW1+dCQibdW6PcP9muariQtWRHY1LI9SYc=";
  };
  remove_vapoursynth_dep_reqtxt = "51";

  vs_binarydeps = with vapoursynthPlugins; [
    fmtconv
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    vs-rgtools
    vs-kernels
    havsfunc
    descale
  ];

  meta = with lib; {
    description = "A small collection of Vapoursynth scripts of varying usefulness";
    homepage = "https://github.com/kgrabs/zzfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
