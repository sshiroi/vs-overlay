{ lib, vapoursynthPlugins, fetchFromGitHub, cmake,  fftw, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "vapoursynth-mvtools-sf";
  version = "unstable-2022-10-15";
  namespace = "mvsf";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "38dadba1ef853a90fab51aa886c455587173630b";
    sha256 = "sha256-dQFHu8DDW7L5RrUraEAlwNrAOgBL2tbQBAgY9jkrUMs=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fftw vapoursynthPlugins.vapoursynth-plusplus ];

  modeb_replace = "vs.get_pkgconfig_variable('libdir')";

  meta = with lib; {
    description = "Single Precision MVTools";
    homepage = "https://github.com/IFeelBloated/vapoursynth-mvtools-sf";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
