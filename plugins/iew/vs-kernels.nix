{ lib, vapoursynthPlugins,  mkVapoursynthPythonSetuptools, fetchFromGitHub  }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-kernels";
  version = "git-2.3.0";
  importname = "vskernels";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "e5dff581bf12c36829e1f2f88c02e03238b689ab";
    sha256 = "sha256-QiDnupI+oEIt0m+lSDtJ3fRU0JUUt7HaY0slkhuNqmo=";
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
