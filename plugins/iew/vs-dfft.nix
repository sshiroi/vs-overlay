{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, numpy, pyfftw }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-dfft";
  version = "git-unstable";
  importname = "vsdfft";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "1e17bc2e9d1884715c71cf56a972e4d0867cabff";
    sha256 = "eFX33GzhqyfYN+6Dq8v98wygqx5C7MLHclJq0wV2gvY=";
  };

  vs_binarydeps = [];
  vs_pythondeps = [];

  propagatedBuildInputs = [ numpy pyfftw ];


  meta = with lib; {
    description = "Collection of Discrete/Fast Fourier Transform VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dfft";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
