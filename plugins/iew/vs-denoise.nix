{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-denoise";
  version = "git-2.0.0";
  importname = "vsdenoise";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "e50e7dff5b6137dd029615e9843a046ba9fb96b1";
    sha256 = "sha256-kl86noAIQiR/2FqWsQX6V3J+EzTrHGy8+HsuE9+VSyQ=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vs-scale
  ];

  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-denoise";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}