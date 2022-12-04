{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth, rich }:
buildPythonPackage rec {
  pname = "vs-tools";
  #version = "1.3.0";
  version = "unstable-2022-11-26";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    #sha256 = "sha256-X98x+Vjs9eGH7smtTaUsWHdWRfFJL79FYA8OQBh+BqA=";
    rev = "4b654f35586b50802cd9058a8d0a5d637f250a6f";
    sha256 = "sha256-n65hvKegrwsgoykyZIwIViGupDMy+X8wQd2bGk4qVFY=";
  };

  propagatedBuildInputs = [ vapoursynthPlugins.vsutil rich ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" ""
    substituteInPlace requirements.txt \
        --replace "rich>=12.6.0" "rich>=12.4.1"
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  checkInputs = [ (vapoursynth.withPlugins [  ]) ];
  pythonImportsCheck = [ "vstools" ];


  meta = with lib; {
    description = "collection of functions, utils, types, type-utils, and more aimed at helping at having a common ground between VapourSynth packages";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-tools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
