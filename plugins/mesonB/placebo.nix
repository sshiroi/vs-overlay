{ lib,  fetchFromGitHub, fetchpatch,  libplacebo,  vulkan-headers, vulkan-loader, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "vs-placebo";
  version = "1.4.2";
  namespace = "placebo";

  src = fetchFromGitHub {
    owner = "Lypheo";
    repo = pname;
    rev = version;
    sha256 = "sha256-nerS1z/Ch/UqcmcY2gNL1Xl3hs1/etEAODj8pzrSuEE=";
    fetchSubmodules = true;
  };

  buildInputs = [ libplacebo vulkan-headers vulkan-loader ];

  meta = with lib; {
    description = "A libplacebo-based debanding, scaling and color mapping plugin for VapourSynth";
    homepage = "https://github.com/Lypheo/vs-placebo";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
