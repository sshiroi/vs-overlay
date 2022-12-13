{ lib, vapoursynthPlugins,  mkVapoursynthPythonSetuptools, fetchFromGitHub  }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-kernels";
  version = "2.2.1";
  importname = "vskernels";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "dffe27bf37f84cec1d71737405d167e2186bc85e";
    sha256 = "sha256-5nPr9qd4ZODP0zyAGWpy+UvYrU0/vsc+PcKIDk8Pvqk=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    descale
    fmtconv
  ];

  remove_vapoursynth_dep_reqtxt = 59;

  meta = with lib; {
    description = "A collection of wrappers pertaining to (de)scaling";
    homepage = "https://vskernels.encode.moe/en/latest/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
