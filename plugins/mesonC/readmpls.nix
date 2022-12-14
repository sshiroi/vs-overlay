{ lib, mkVapoursynthMesonB, fetchFromGitHub, libbluray }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-ReadMpls";
  version = "5";
  namespace = "mpls";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-cQaGasNRI0p6sz1hecErDrw6lf6G3vk98SshGdRMn+Y=";
  };

  buildInputs = [ libbluray ];

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;

  meta = with lib; {
    description = "ReadMpls filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-ReadMpls";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
