{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-aa";
  version = "git-unstable";
  importname = "vsaa";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "5ef4cdba39631ad8601747907a9a646b8b0bd1bd";
    sha256 = "SqrKoIrQMb1ZHrtp2MWsAFvYSStCGiiUKvXzx4fK23A=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vsmask
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-masktools
  ];

  vs_binarydeps = [];

  meta = with lib; {
    description = "anti aliasing and scaling functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-aa";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
