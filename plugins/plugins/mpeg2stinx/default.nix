{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, llvmPackages,  ffmpeg_4, vapoursynth }:

rustPlatform.buildRustPackage rec {
  pname = "vapoursynth-mpeg2stinx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "shssoichiro";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-vNSd/yRwwDtoo/q77pgzQ2Yaed4eOeTxYJ0qjYGOmSQ=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [  ];

  cargoPatches = [
    ./add_cargo_lock_pin_vapoursynth_rs.patch
  ];

  cargoSha256 = "sha256-1wlWUE2StYR4vRUOWuCVDEmurK0LsYkzSbyblLc0Vmo=";

  postInstall = ''
  mkdir $out/lib/vapoursynth
  mv $out/lib/*.so $out/lib/vapoursynth
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "mpeg2stinx";

  meta = with lib; {
    description = "MPEG2Stinx filter ported to VapourSynth ";
    homepage = "https://github.com/shssoichiro/vapoursynth-mpeg2stinx";
    license = licenses.mit; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}