{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, vapoursynth, poetry-core, pyyaml }:

buildPythonPackage rec {
  pname = "dnfunc";
  version = "0.0.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "DeadNews";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-8l3HkaHTH2E7SESdAwO2yKpDSl/B4YthVwqYFIuFGFA=";
  };

  postPatch = ''
  substituteInPlace pyproject.toml --replace 'vapoursynth = "^61"' ""
  #todo: havsfunc isn't packaged properly (as a single file) we need to fix that
  substituteInPlace pyproject.toml --replace 'havsfunc = "^33"' ""




  #???????
  substituteInPlace src/dnfunc/__init__.py --replace 'import insane_aa as iaa' "import insaneAA as iaa"
  '';

  propagatedBuildInputs =  with vapoursynthPlugins; [
    poetry-core

    havsfunc
    pyyaml
    vsutil
    vs-tools

    insaneAA
    kagefunc
  ];

  checkInputs = [
    vapoursynth
  ];

  pythonImportsCheck = [ "dnfunc" ];

  meta = with lib; {
    description = "A collection of Vapoursynth functions and wrappers ";
    homepage = "https://github.com/DeadNews/dnfunc";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
