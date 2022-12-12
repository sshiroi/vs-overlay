{ lib, fetchFromGitHub, buildPythonPackage, python, vapoursynthPlugins, vapoursynth }:

let
  plugins_native = with vapoursynthPlugins; [
    minideen
    msmoosh
    mvtools
    temporalmedian
    temporalsoften2
  ];
in
buildPythonPackage rec {
  pname = "vapoursynth-dfmderainbow";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "44dc6545bced8fc25672bdda717943a02c6b5d71";
    sha256 = "sha256-0+DnuQKLaO4AHSK7o0LRpYI1oaYVe8qVgfq1K555afI=";
  };

  format = "other";

  propagatedBuildInputs = plugins_native;

  installPhase = ''
    runHook preInstall
    install -D dfmderainbow.py $out/${python.sitePackages}/dfmderainbow.py
    runHook postInstall
  '';

  checkInputs = [ (vapoursynth.withPlugins plugins_native ) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "dfmderainbow" ];

  meta = with lib; {
    description = "DFMDerainbow is a derainbow function for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-dfmderainbow";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}