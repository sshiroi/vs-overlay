{ lib, vapoursynthPlugins,  mkVapoursynthPythonSetuptools, fetchFromGitHub  }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-kernels";
  version = "git-2.4.1";
  importname = "vskernels";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "a467b96ad7be3c2d9f40f6b8cd7b8490ff7a422c";
    sha256 = "sha256-oIVEw31MXQzNVvcKCNdgEzvN1Q9t+0r5y01yJHF7v/Y=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    descale
    fmtconv
  ];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "A collection of wrappers pertaining to (de)scaling";
    homepage = "https://vskernels.encode.moe/en/latest/";
    #homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-kernels";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
