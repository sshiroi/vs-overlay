{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth, rich }:
buildPythonPackage rec {
  pname = "vs-tools";
  #version = "1.6.7";
  version = "unstable-2022-12-10";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "28a15b8e30a0844fdbac6d9173fe02339a8bb7d5";
    sha256 = "sha256-tuEX7yFrk4qNnXjIPSn3JQv+FYNA0eg+6he8vVFb748=";
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
