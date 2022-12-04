{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, rich, toolz,  vapoursynth, pythonOlder }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    fmtconv
  ];
in
buildPythonPackage rec {
  pname = "vs-kernels";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "dffe27bf37f84cec1d71737405d167e2186bc85e";
    sha256 = "sha256-5nPr9qd4ZODP0zyAGWpy+UvYrU0/vsc+PcKIDk8Pvqk=";
  };

  propagatedBuildInputs = [ vapoursynth vapoursynthPlugins.vs-tools ] ++ propagatedBinaryPlugins;

  postPatch = ''
    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" "" \
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "vskernels" ];

  inherit propagatedBinaryPlugins;

  meta = with lib; {
    description = "A collection of wrappers pertaining to (de)scaling";
    homepage = "https://vskernels.encode.moe/en/latest/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
