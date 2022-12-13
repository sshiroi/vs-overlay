{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
buildPythonPackage rec {
  pname = "vsmask";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-hXMgqess4Vc3vsSQEb4rbwRfZadjtzR6Bm32Wztaa8M=";
  };

  propagatedBuildInputs = [ vapoursynthPlugins.vsutil ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth==60" ""
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  checkInputs = [ (vapoursynth.withPlugins [  ]) ];
  pythonImportsCheck = [ "vsmask" ];


  meta = with lib; {
    description = "Tools and functions to manage, create, and manipulate masks in VapourSynth.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsmask";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
