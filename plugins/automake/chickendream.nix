{ lib, fetchFromGitHub, pkg-config, which, mkVapoursynthAutomake  }:

mkVapoursynthAutomake rec {
  pname = "chickendream";
  version = "2";
  namespace = "chkdr";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = pname;
    rev = "r2";
    sha256 = "sha256-YnrqVS8KBWekWA/w4zJT2jW0OV1+/f/sbZyk5xQ7HkI=";
  };

  preAutoreconf = "cd build/unix";

  meta = with lib; {
    description = "realistic film grain";
    homepage = "https://github.com/EleonoreMizo/chickendream";
    license = with licenses; [ wtfpl ];
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
