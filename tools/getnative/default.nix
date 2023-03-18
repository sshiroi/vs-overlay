{ lib, vapoursynth, vapoursynthPlugins, buildPythonApplication, fetchFromGitHub, matplotlib, imagemagick }:
let
  vapoursynth-with-plugins = vapoursynth.withPlugins (with vapoursynthPlugins; [
    ffms2
    descale
  ]);
in
buildPythonApplication rec {
  pname = "getnative";
  version = "3.2.1";

  src = fetchFromGitHub {
    owner = "Infiziert90";
    repo = pname;
    # The version in setup.py is 3.0.2, but there is no tag for it
    # (the tag that GitHub shows as 3.0.2 actually is 3.0.0)
    rev = version;
    sha256 = "sha256-q9Idu7cj19c4kJ5dHj1stBj7OMsI/LVNol6cT1Dj00o=";
  };

  # vapoursynth is not recognised during installation
  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=55" ""
  '';

  propagatedBuildInputs = [
    matplotlib
    vapoursynth-with-plugins
  ];

  nativeCheckInputs = [ imagemagick ];
  checkPhase = ''
    convert -size 1280x720 canvas: +noise Random test.png
    $out/bin/getnative --min-height 699 --max-height 700 test.png
    $out/bin/getnative --min-height 699 --max-height 700 -u ffms2.Source test.png
  '';

  meta = with lib; {
    description = "A cli tool to find the native resolution(s) of upscaled material (mostly anime)";
    homepage = "https://github.com/Infiziert90/getnative";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
