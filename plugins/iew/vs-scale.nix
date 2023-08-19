{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-scale";
  version = "git-unstable";
  importname = "vsscale";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "44c539e3a0eac9c256f7cb01a4a5d235a0669dce";
    sha256 = "XqSLDAQlv7EFwHysVhg9Ic4kaPxszCTsHYbXVV5qiBc=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vsmask
  ];
  vs_binarydeps = [];

  meta = with lib; {
    description = "Wrappers for scaling and descaling functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-scale";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
