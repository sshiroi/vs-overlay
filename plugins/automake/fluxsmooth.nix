{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-fluxsmooth";
  version = "2";
  namespace = "flux";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "0z227yiyd5dss9556n024g71l5hp4ghbdwfs88han2crff6rfpdv";
  };

  meta = with lib; {
    description = "A vapoursynth filter plugin for smoothing of fluctuations";
    homepage = "https://github.com/dubhater/vapoursynth-fluxsmooth";
    license = licenses.unfree; # no license for current version (base is public domain)
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
