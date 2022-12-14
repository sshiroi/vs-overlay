{ lib, mkVapoursynthMesonB, fetchFromGitHub }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-Bwdif";
  version = "4.1";
  namespace = "bwdif";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "${pname}";
    rev = "r${version}";
    sha256 = "sha256-wpALZMSKX+LvbPOL1DpqumfT1Ql4Kbi4Mi7U2nooZmQ=";
  };

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;

  meta = with lib; {
    description = "Motion adaptive deinterlacing based on yadif";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bwdif";
    license = licenses.gpl2;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
