{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, rich, toolz,  vapoursynth, pythonOlder }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    fmtconv
  ];
in
buildPythonPackage rec {
  pname = "vs-kernels";
  #version = "1.1.3";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "c57f0ee7abd9045fdabdc2242bf7dbf4776f0547";
    sha256 = "sha256-Xm0jUsXdEdICdUWUjz1Iovkno6XuvcTsGgpOT5YNvK8=";
    #rev = "v${version}";
    #sha256 = "sha256-rodgc2Ulm4QG/4yidrA5FVW4inAM6Ticuye5xUYjqlo=";
  };

  propagatedBuildInputs = [ vapoursynth propagatedBinaryPlugins ];

  postPatch = ''
    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=51" "" \
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "vskernels" ];

  meta = with lib; {
    description = "A collection of wrappers pertaining to (de)scaling";
    homepage = "https://vskernels.encode.moe/en/latest/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
