{ lib, stdenv, fetchFromGitHub, pkg-config, fuse }:
stdenv.mkDerivation rec {
  name = "concatfs";
  version = "unstable-2022-09-25";

  src = fetchFromGitHub {
    owner = "schlaile";
    repo = name;
    rev = "84ef3cc5089ed288bb368f55929234464a0056af";
    sha256 = "sha256-3VqCHjDekP2K4Y8Jv5dlI2BC43hxhgiqK/sAhaKFp58=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ fuse ];

  buildPhase = ''
  $CC src/concatfs.c `pkg-config fuse --cflags --libs` -o concatfs
  '';

  installPhase = ''
  install -D concatfs $out/bin/concatfs
  '';

  meta = with lib; {
    description = "Filesystem in Userspace for easy file concatenation of big files";
    homepage = "https://github.com/schlaile/concatfs";
    license = licenses.unfree; # no license
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}