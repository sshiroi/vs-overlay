{ lib, mkVapoursynthMesonB, fetchFromGitHub }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-AddGrain";
  version = "10";
  namespace = "grain";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-HNdYDpoyhWkpZZhcji2tWxWTojXKTKBbvm+iHp6Zdeo=";
  };

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;


  meta = with lib; {
    description = "AddGrain filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
