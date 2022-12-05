{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:
buildPythonPackage rec {
  pname = "cooldegrain";
  version = "unstable-2022-12-05";

  src = fetchFromGitHub {
    owner = "MiraiAnime";
    repo = "vapoursynth-stuff";
    rev = "a7454339b7b77908b1faec7547be54718904509a";
    sha256 = "sha256-1QqLRPz8D6LSkYQ3w+DVKr8AHZRY0SPW70rYOsEXMrE=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    fmtconv
    mvtools
  ];

  format = "other";

  installPhase = ''
    install -D cooldegrain.py $out/${python.sitePackages}/cooldegrain.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "cooldegrain" ];

  meta = with lib; {
    description = "CoolDegrain-Vapoursynth.";
    homepage = "https://github.com/MiraiAnime/vapoursynth-stuff";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
