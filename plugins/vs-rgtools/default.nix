{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth, numpy, pyfftw }:
buildPythonPackage rec {
  pname = "vs-rgtools";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "fde8efcbb470199d598eecfe13ab4b8033829330";
    sha256 = "sha256-E4tPgRf2UMUW6ijkWm0G0r+POKfieeylPfYo88FwB8U=";
  };

  propagatedBuildInputs = [ numpy pyfftw vapoursynthPlugins.vs-exprtools ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" ""
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';

  meta = with lib; {
    description = "Wrapper for RGVS, RGSF, and various other functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-rgtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
