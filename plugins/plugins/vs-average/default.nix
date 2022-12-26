{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, vapoursynth }:

rustPlatform.buildRustPackage rec {
  pname = "vs-average";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "End-of-Eternity";
    repo = pname;
    rev = "v${version}-beta";
    sha256 = "sha256-YRhb02AU+YZTmucAkv/e0eZpDkvDJ1d7x8RtPBqOGZQ=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [  ];

  cargoPatches = [
    ./add_cargo_lock.patch
  ];

  cargoSha256 = "sha256-yrxQ+UXJ5xc3IUb5SK0HKOEDMUKf6xGCVAHD6/YoRDU=";

  postInstall = ''
  mkdir $out/lib/vapoursynth
  mv $out/lib/*.so $out/lib/vapoursynth
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "average";

  meta = with lib; {
    description = "A VapourSynth plugin for averaging clips together";
    homepage = "https://github.com/End-of-Eternity/vs-average";
    license = licenses.mit; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}