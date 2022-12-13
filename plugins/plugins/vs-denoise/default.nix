{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
buildPythonPackage rec {
  pname = "vs-denoise";
  #version = "1.2.0";
  version = "unstable-2022-12-10";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "344be7830e4b93285811bbd9c90baec2859bb551";
    sha256 = "sha256-1nBaE5P56dAHpJT849HyZZH8i5BGrXI2uvmf/alZB0c=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vs-scale
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" ""
  '';

  propagatedBinaryPlugins = [ ] ++ vapoursynthPlugins.vs-kernels.propagatedBinaryPlugins;

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins )  ];
  pythonImportsCheck = [ "vsdenoise" ];

  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-denoise";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
