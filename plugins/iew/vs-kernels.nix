{ lib, vapoursynthPlugins,  mkVapoursynthPythonSetuptools, fetchFromGitHub  }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-kernels";
  version = "git-2.4.1";
  importname = "vskernels";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "2ddd1c5454ecbb2a548694c06069b484c0b20186";
    sha256 = "sha256-h6Eri5kmxA1KZ9DcB+pcMq23O51DdUGWTJ4M6i5gn3c=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    descale
    fmtconv
  ];

  meta = with lib; {
    description = "A collection of wrappers pertaining to (de)scaling";
    homepage = "https://vskernels.encode.moe/en/latest/";
    #homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-kernels";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
