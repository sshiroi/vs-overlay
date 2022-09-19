{ lib, buildPythonPackage, fetchFromGitHub, vapoursynth }:
buildPythonPackage rec {
  pname = "VapourSynth-Plugins-Stub-Generator";
  version = "unstable-2022-09-19";

  propagatedBuildInputs = [ vapoursynth ];

  sourceRoot = "${src.name}/vsstubs";

  src = fetchFromGitHub {
    owner = "SaltyChiang";
    repo = "${pname}";
    rev = "74d8d310ac279d773c59feebe79190e777387991";
    sha256 = "sha256-S4OqAQqA+IZjGYxPXiUqXeduLWspjilqvFYgoEzejOY=";
  };

  meta = with lib; {
    description = "An unofficial stub generator for vapoursynth and its plugins.";
    homepage = "https://github.com/SaltyChiang/VapourSynth-Plugins-Stub-Generator";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}