{ lib, mkVapoursynthMesonB, fetchFromGitHub, imagemagick, libheif }:

mkVapoursynthMesonB rec {
  pname = "vs-imwri";
  version = "2";
  namespace = "imwri";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-1YDmpFZ3S75OjpNoSXOZOtsi1BrI+sFCrtcWdqNrMCA=";
  };

  buildInputs = [ imagemagick libheif ];

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;

  meta = with lib; {
    description = "Image reader and writer for VapourSynth using the ImageMagick library";
    homepage = "https://github.com/vapoursynth/vs-imwri";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
