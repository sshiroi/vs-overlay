{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "VS-MaskDetail";
  version = "3.0";
  importname = "MaskDetail";

  src = fetchFromGitHub {
    owner = "MonoS";
    repo = pname;
    rev = "V${version}";
    sha256 = "sha256-ssM8LfeolNoigEZePhiAz2lpN5RZ1wh8aoZS3c38TfE=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    descale
    fmtconv
    removegrain
  ];

  vs_pythondeps = [];

  meta = with lib; {
    description = "For detail masking";
    homepage = "https://github.com/MonoS/VS-MaskDetail/";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
