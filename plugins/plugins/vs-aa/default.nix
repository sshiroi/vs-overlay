{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth, rich,  filter_python_plugins }:
buildPythonPackage rec {
  pname = "vs-aa";
  version = "unstable-2022-11-26";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "fca442a0f348a0202d7eb45f666fd64ecbf6cf49";
    sha256 = "sha256-YGNvwZcXnLM+5e34RIz092TQsM7Ch1Jr9HQekqb9eGM=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    vsutil
    vsmask
    vs-kernels
    vs-exprtools
    vs-rgtools
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" ""
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins )  ];
  pythonImportsCheck = [ "vsaa" ];

  propagatedBinaryPlugins = [] ++ vapoursynthPlugins.vs-kernels.propagatedBinaryPlugins;

  meta = with lib; {
    description = "anti aliasing and scaling functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-aa";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
