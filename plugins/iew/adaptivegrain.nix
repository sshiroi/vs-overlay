{ lib, stdenv, fetchFromGitHub, rustPlatform, vapoursynth }:
let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in
rustPlatform.buildRustPackage rec {
  pname = "adaptivegrain";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "sha256-ZP3bYxGVLW89lz1HxlYn7P46sT4cKPfm6UNodTICuuk=";
  };

  cargoSha256 = "1fy2n6afn7hxkwxf8l6jdakqpq97rn5dqav1bagzm2n40m37ldfk";

  postInstall = ''
    mkdir $out/lib/vapoursynth
    mv $out/lib/libadaptivegrain_rs${ext} $out/lib/vapoursynth/libadaptivegrain_rs${ext}
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "adg";

  meta = with lib; {
    description = "Reimplementation of the adaptive_grain mask as a Vapoursynth plugin";
    homepage = "https://git.kageru.moe/kageru/adaptivegrain";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
