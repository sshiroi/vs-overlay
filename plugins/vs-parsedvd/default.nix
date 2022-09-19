{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub,  vapoursynth, pythonOlder }:
let
pyparsedvd = buildPythonPackage rec {
  pname = "pyparsedvd";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "Ichunjo";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-McSlckV+cOB7coSLpL6NAAw0keV4mFhbU/+KPGjjjQQ=";
  };
};
in
buildPythonPackage rec {
  pname = "vs-parsedvd";
  version = "unstable-2022-09-19";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "09adf02d202d4507ed35de95ea15d436f2888e2b";
    sha256 = "sha256-vvwCyHZU0oBwKpTAI9H92qtklxq0Kxr3yJFJ4pDbE0A=";
  };

  propagatedBuildInputs = [ pyparsedvd vapoursynth vapoursynthPlugins.d2vsource  ];

  patches = [
    ./patch.patch
  ];

  postPatch = ''
    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" "" \
  '';

  # Tests don't even work under arch
  doCheck = false;
  #  checkInputs = [ (vapoursynth.withPlugins [ vapoursynthPlugins.d2vsource ]) ];
  #  pythonImportsCheck = [ "vsparsedvd" ];

  meta = with lib; {
    description = "A wrapper for DVD file structure and ISO files.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-parsedvd";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
