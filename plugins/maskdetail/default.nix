{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    fmtconv
    removegrain
  ];
in
buildPythonPackage rec {
  pname = "VS-MaskDetail";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "MonoS";
    repo = pname;
    rev = "V${version}";
    sha256 = "sha256-ssM8LfeolNoigEZePhiAz2lpN5RZ1wh8aoZS3c38TfE=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    descale
  ] ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D MaskDetail.py $out/${python.sitePackages}/MaskDetail.py
  '';

  checkInputs = [ (vapoursynth.withPlugins ( propagatedBinaryPlugins )) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "MaskDetail" ];

  meta = with lib; {
    description = "For detail masking";
    homepage = "https://github.com/MonoS/VS-MaskDetail/";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
