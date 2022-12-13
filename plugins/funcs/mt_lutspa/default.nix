{ lib, mkVapoursynthPythonSinglefileFunc, fetchgit, numpy, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "mt_lutspa";
  version = "unstable-2015-10-14";
  importname = "mt_lutspa";

  src = fetchgit {
    url = "https://gist.github.com/tp7/1e39044e1b660ef0a02c";
    rev = "4ab492db4431bd27466b42d96bc5878db822499e";
    sha256 = "0szws6fcrcgdn31szhrmglpl2kglrglx1bgxd0bjl3r51bxiry12";
  };

  patches = [
    ./0001-Use-vs.core-instead-of-vs.get_core.patch
  ];

  vs_binarydeps = [];
  vs_pythondeps = [];

  propagatedBuildInputs = [
    numpy
  ];

  meta = with lib; {
    description = "A vapoursynth plugin to computes the value of a pixel according to its spatial position";
    homepage = "https://gist.github.com/tp7/1e39044e1b660ef0a02c";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
