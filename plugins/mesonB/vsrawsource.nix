{ lib, fetchFromGitHub, mkVapoursynthMesonB}:

 mkVapoursynthMesonB rec {
  pname = "vsrawsource";
  version = "unstable-2022-11-25";
  namespace = "raws";

  #no idea which fork to use
  src = fetchFromGitHub {
    owner = "HolyWu";
    repo = pname;
    rev = "82400b7ad8e57cb71cc7cde44e36579cf40455f0";
    sha256 = "sha256-op3XH0C7aDYRXKT6B5Oho+xG118jVSyBZJL20ZVx/zg=";
  };

  meta = with lib; {
    description = "raw(uncompressed) video source filter";
    homepage = "https://github.com/HolyWu/vsrawsource";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
