{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-dpid";
  #version = ">r5";
  version = "unstable-2022-12-12";
  namespace = "dpid";

  src = fetchFromGitHub {
    owner = "WolframRhodium";
    repo = pname;
    rev = "89cc7a717213bb4cceb73297a13b3a98ec5dadfc";
    sha256 = "sha256-N+n4Ch2BsS4dJVKcZ2VbseeXw9e3ffSeG8wd244Y2o4=";
  };

  sourceRoot = "${src.name}/Source";

  meta = with lib; {
    description = "Rapid, Detail-Preserving Image Downscaler for VapourSynth";
    homepage = "https://github.com/WolframRhodium/VapourSynth-dpid";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}