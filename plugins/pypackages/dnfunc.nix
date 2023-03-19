{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, vapoursynth, poetry-core, pyyaml }:
let
vstools = { lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, rich }:
mkVapoursynthPythonSetuptools rec {
  pname = "vs-tools";
  #version = "1.6.7";
  version = "unstable-2022-12-10";
  importname = "vstools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "28a15b8e30a0844fdbac6d9173fe02339a8bb7d5";
    sha256 = "sha256-tuEX7yFrk4qNnXjIPSn3JQv+FYNA0eg+6he8vVFb748=";
  };

  vs_pythondeps =  with vapoursynthPlugins; [ vsutil ];
  vs_binarydeps = [];

  propagatedBuildInputs = [ rich ];

  remove_vapoursynth_dep_reqtxt = 59;

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
};
in
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

  #todo: no idea if ok bypass version check
  substituteInPlace pyproject.toml --replace 'vstools = "^1.6.2"' ""




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
