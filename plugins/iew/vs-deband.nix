{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-deband";
  version = "git-1.0.1";
  importname = "vsdeband";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "2935dc68c184beff8349cc44bc02b24d9cecf200";
    sha256 = "sha256-GeHl07eTl60nGReuILf10le6j6/VM7GUkMzkSwD2ZBM=";
  };

  remove_vapoursynth_dep_reqtxt = 60;

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
    vs-rgtools
    vs-kernels
    vs-exprtools
    vsmask
    vs-scale

    vs-denoise#missing in requirements
  ];
  vs_binarydeps = with vapoursynthPlugins; [
    morpho
  ];

  doCheck = false;

  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-deband";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
