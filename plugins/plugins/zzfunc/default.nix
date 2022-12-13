{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, matplotlib, python, vapoursynth }:
buildPythonPackage rec {
  pname = "zzfunc";
  version = "unstable-2022-09-17";

  src = fetchFromGitHub {
    owner = "kgrabs";
    repo = pname;
    rev = "febe2665d9c7c1689398ef9200578a32992e2921";
    sha256 = "rXz99dDk6UW1+dCQibdW6PcP9muariQtWRHY1LI9SYc=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    vs-rgtools
    havsfunc
    vs-kernels
    descale
    fmtconv
  ];
  postPatch = ''
    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=51" "" \
  '';

#  format = "other";
#  installPhase = ''
#    install -d zzfunc $out/${python.sitePackages}/zzfunc
#  '';

  checkInputs = [ (vapoursynth.withPlugins (with vapoursynthPlugins; [  descale fmtconv ])) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "zzfunc" ];

  meta = with lib; {
    description = "A small collection of Vapoursynth scripts of varying usefulness";
    homepage = "https://github.com/kgrabs/zzfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
