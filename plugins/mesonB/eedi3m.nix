{ lib,  fetchFromGitHub, mkVapoursynthMesonB, boost, opencl-headers, ocl-icd }:

mkVapoursynthMesonB rec {
  pname = "vapoursynth-eedi3";
  version = "4";
  namespace = "eedi3m";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-EEDI3";
    rev = "r${version}";
    sha256 = "1q79l27arcfl7k49czsspb4z7zfr616xsxsb04x9b4d9l763716x";
  };

  buildInputs = [ boost opencl-headers ocl-icd ];

  # https://github.com/NixOS/nixpkgs/issues/86131
  BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
  BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";

  meta = with lib; {
    description = "Renewed EEDI3 filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
