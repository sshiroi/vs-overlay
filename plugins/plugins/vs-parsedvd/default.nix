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
  version = "unstable-2022-11-26";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "b78721abe54614e24e0a111ae033c0585d687340";
    sha256 = "sha256-qlPtiJeZL/PjnzK0rnZ4cmif1kxDRHieYUKYb1/CH+M=";
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
