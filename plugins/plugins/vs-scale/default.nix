{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
buildPythonPackage rec {
  pname = "vs-scale";
  #version = "1.2.0";
  version = "unstable-2022-11-26";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    #sha256 = "sha256-X98x+Vjs9eGH7smtTaUsWHdWRfFJLasddsa9FYA8OQBh+BqA=";
    rev = "3e7aa2685fc1e2f3c717449e0971be85058c0a90";
    sha256 = "sha256-Q4IueAlNcQPKCi97btAHpd8z1ZopaDkoNy1tHKhDhtk=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vsmask
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
  pythonImportsCheck = [ "vsscale" ];


  meta = with lib; {
    description = "Wrappers for scaling and descaling functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-scale";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
