{ lib, buildPythonPackage, fetchFromGitHub, python, vapoursynth }:

buildPythonPackage rec {
  pname = "vapoursynth-Hysteria";
  version = "unstable-2022-09-25";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "32c301447a7ab9690664ac454ed2a135624dbed3";
    sha256 = "sha256-SPsFj2tIOAyJygUSs/QnGg5KFKbE0jD1S3muZFCtdh8=";
  };

  format = "other";

  installPhase = ''
    install -D hysteria.py $out/${python.sitePackages}/hysteria.py
  '';

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';

  pythonImportsCheck = [ "hysteria" ];

  meta = with lib; {
    description = "Line darkening script function";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria";
    #https://forum.doom9.org/showthread.php?t=172710
    #https://www.animemusicvideos.org/forum/viewtopic.php?t=101471
    license = licenses.unfree;# no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
