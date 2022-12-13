{ lib,  fetchFromGitHub, boost, ocl-icd, opencl-headers, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-NNEDI3CL";
  version = "8";
  namespace = "nnedi3cl";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "0j99ihxy295plk1x5flgwzjkcjwyzqdmxnxmda9r632ksq9flvyd";
  };

  buildInputs = [ boost ocl-icd opencl-headers ];

  # https://github.com/NixOS/nixpkgs/issues/86131
  BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
  BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";

  meta = with lib; {
    description = "An OpenCL accelerated nnedi3 filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
