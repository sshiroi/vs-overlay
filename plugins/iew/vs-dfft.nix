{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, numpy, pyfftw }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-dfft";
  version = "0.1.0";
  importname = "vsdfft";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-55QkAj2uUwTbSItOxcVDybO929566mqxJyKFXkGVwQw=";
  };

  vs_binarydeps = [];
  vs_pythondeps = [];

  propagatedBuildInputs = [ numpy pyfftw ];
  remove_vapoursynth_dep_reqtxt = 59;


  meta = with lib; {
    description = "Collection of Discrete/Fast Fourier Transform VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dfft";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
