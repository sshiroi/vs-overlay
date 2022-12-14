{ lib, mkVapoursynthMesonB, fetchFromGitHub }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-TTempSmooth";
  version = "4.1";
  namespace = "ttmpsm";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-T+QudM6FUKLkEEwPiHVkDXTkS1SKB/QnWf3cMx85dUA=";
  };

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;

  meta = with lib; {
    description = "A TTempSmooth filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TTempSmooth";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
