{ lib, fetchFromGitHub, mkVapoursynthMesonB}:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-TColorMask";
  version = "unstable-2022-12-04";
  namespace = "tcm";

  src = fetchFromGitHub {
    owner = "Beatrice-Raws";
    repo = pname;
    rev = "e290062cc8c1f912aad9ec72c354734d7652d4c0";
    sha256 = "sha256-ZLzYxWnWqjSHzpYaAUUenr3bID8HTe98h4fujbQkNVY=";
  };

  meta = with lib; {
    description = "Great solution if you need to build some masks on color values. ";
    homepage = "https://github.com/Beatrice-Raws/VapourSynth-TColorMask";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
