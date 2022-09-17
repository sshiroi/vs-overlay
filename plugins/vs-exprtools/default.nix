{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
buildPythonPackage rec {
  pname = "vs-exprtools";
  version = "unstable-2022-09-17";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "c9f595ef6ebdbb38bfc692dd3a47cdbda163d4df";
    sha256 = "sha256-5XZ9gm+Z5gCV2CloGwVh2TbTGQMjsRfCXU4i7CgaHSM=";
  };

  propagatedBuildInputs = [ vapoursynthPlugins.vsutil ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" ""
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';

  meta = with lib; {
    description = "VapourSynth functions and helpers for writing RPN expressions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-exprtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
