{ lib, stdenv,mkVapoursynthMesonB, fetchFromGitHub, cmake, libvmaf }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-VMAF";
  version = "10";
  namespace = "vmaf";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-p7tLNgTdaFNDfKZjaY8ha38yq+45nQYvYS00QD9ox1Y=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ libvmaf ];

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;

  meta = with lib; {
    description = "Video Multi-Method Assessment Fusion";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VMAF";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
