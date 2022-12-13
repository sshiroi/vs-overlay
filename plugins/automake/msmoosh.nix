{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-msmoosh";
  version = "1.1";
  namespace = "msmoosh";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1lqz5xml3j2fs6acrihf1sfhf1397kxsra9j6ky00wll8klcnv0d";
  };

  meta = with lib; {
    description = "A VapourSynth plugin providing MSharpen and MSmooth";
    homepage = "https://github.com/dubhater/vapoursynth-msmoosh";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
