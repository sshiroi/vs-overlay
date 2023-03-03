{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, llvmPackages,  ffmpeg_4, vapoursynth }:

rustPlatform.buildRustPackage rec {
  pname = "bdngsp";
  version = "unstable-2022-09-22";

  src = fetchFromGitHub {
    owner = "sshiroi";
    repo = pname;
    rev = "4ecf69c9cdd93ab5290f415e9ef6bb8a26edd143";
    sha256 = "sha256-gnyjV61jqZLXGM56ycH4bvbgQY3GBvu8TQQ9tcWxLUE=";
  };

  nativeBuildInputs = [ pkg-config llvmPackages.clang ];
  buildInputs = [ ffmpeg_4 ];

  LIBCLANG_PATH="${llvmPackages.libclang.lib}/lib";

  cargoSha256 = "sha256-WuwLRYHB/YKltfc7FcjQqejyM/wAKzwWQZ1xPnTFXj8=";

  postInstall = ''
  mkdir $out/lib/vapoursynth
  mv $out/lib/*.so $out/lib/vapoursynth
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "bdngsp";

  meta = with lib; {
    description = "vapoursynth BD source thats Not Good but should Suffice for Preview";
    homepage = "https://github.com/sshirioi/bdngsp";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}