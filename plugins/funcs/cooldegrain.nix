{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "cooldegrain";
  version = "unstable-2022-12-05";
  importname = "cooldegrain";

  src = fetchFromGitHub {
    owner = "MiraiAnime";
    repo = "vapoursynth-stuff";
    rev = "a7454339b7b77908b1faec7547be54718904509a";
    sha256 = "sha256-1QqLRPz8D6LSkYQ3w+DVKr8AHZRY0SPW70rYOsEXMrE=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    fmtconv
    mvtools
  ];

  vs_pythondeps = [ ];

  meta = with lib; {
    description = "CoolDegrain-Vapoursynth.";
    homepage = "https://github.com/MiraiAnime/vapoursynth-stuff";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
