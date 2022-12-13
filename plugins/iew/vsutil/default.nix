{ lib, mkVapoursynthPythonSetuptools, fetchFromGitHub, fetchpatch, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vsutil";
  version = "unstable-2022-12-13";
  importname = "vsutil";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "fc0629e8b3fe691d7493e2a9fbc070890e7e9918";
    sha256 = "sha256-PrX6BXW6PSzMS3viMEPUTiTUEKmhu44zE/huRzPwIlA=";
  };

  patches = [
    # Vapoursynth is not recognised during installation. Since this package
    # provides tests, a dependency problem should be catched by them.
    ./disable-vapoursynth-install-requirement.diff
    # By default, test failure does not fail the build.
    ./fail-tests.diff
  ];

  vs_binarydeps = [];
  vs_pythondeps = [];

  checkInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A collection of general purpose Vapoursynth functions to be reused in modules and scripts";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsutil";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
