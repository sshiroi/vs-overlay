{ lib, buildPythonPackage, fetchFromGitHub, fetchpatch, vapoursynth }:

buildPythonPackage rec {
  pname = "vsutil";
  version = "unstable-2022-09-17";

  # there are no tests in the pypi tarball
  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "ab57bfee61b149ff7824068ac40d5d9544c1c64e";
    sha256 = "sha256-8CW8CirNRtCuz4BDwW/111pEFsxpLYdeai3j/tp8GtI=";
  };

  patches = [
    # Vapoursynth is not recognised during installation. Since this package
    # provides tests, a dependency problem should be catched by them.
    ./disable-vapoursynth-install-requirement.diff
    # By default, test failure does not fail the build.
    ./fail-tests.diff
  ];

  checkInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A collection of general purpose Vapoursynth functions to be reused in modules and scripts";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsutil";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
