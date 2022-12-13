{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, numpy, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    fillborders
    placebo
    remap
  ];
  #todo fill optional plugins
in
buildPythonPackage rec {
  pname = "awsmfunc";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "OpusGang";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-XPDtcPIcA+40+8cGWOEp/6riv4aW8o5jF3C9iGSqDl8=";
  };

  # This does not depend on vapoursynth (since this is used from within
  # vapoursynth).
  postPatch = ''
    substituteInPlace setup.py \
        --replace "VapourSynth>=57" ""
  '';

  propagatedBuildInputs = [
    numpy
  ] ++ (with vapoursynthPlugins; [
    rekt
    vsutil
  ]);

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "awsmfunc" ];

  meta = with lib; {
    description = "A VapourSynth function collection";
    homepage = "https://github.com/OpusGang/awsmfunc";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}