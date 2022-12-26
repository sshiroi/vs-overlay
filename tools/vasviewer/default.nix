{ lib, fetchFromGitLab, stdenv, runCommand, makeWrapper, freetype, libpng, ninja, fontconfig, vapoursynth, pkg-config, xorg, buildVapoursynthConfigFile }:
let
  unwrapped = stdenv.mkDerivation rec {
    pname = "vasviewer";
    version = "1.0.2";

    src = fetchFromGitLab {
      owner = "azelpg";
      repo = pname;
      rev = "2ef542ea1a66c6d65a0b2a6e72f6fbbdc53629ed";
      sha256 = "sha256-nYkcFr8Ud5vIb9CzDCt3+3D9fl6KMLcn+uC2gd5QpOI=";
    };

    nativeBuildInputs = [ pkg-config ninja ];
    buildInputs = [
      xorg.libxcb
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      xorg.libxcb
      libpng
      freetype
      fontconfig
      vapoursynth
    ];

    configurePhase = ''
    ./configure --prefix=$out
    cd build
    '';

    meta = with lib; {
      description = "VapourSynth viewer";
      homepage = "https://gitlab.com/azelpg/vasviewer";
      license = licenses.mit;
      platforms = [ "x86_64-linux" ];
      maintainers = with maintainers; [ ];
    };
  };
  withPlugins = plugins: let
    vapoursynthWithPlugins = vapoursynth.withPlugins plugins;

    cfgg = buildVapoursynthConfigFile plugins;
  in runCommand "${unwrapped.name}-with-plugins" {
    buildInputs = [ makeWrapper ];
    passthru = { withPlugins = plugins': withPlugins (plugins ++ plugins'); };
  } ''
    mkdir -p $out/bin
    makeWrapper ${unwrapped}/bin/vasviewer $out/bin/vasviewer \
        --prefix PYTHONPATH : ${vapoursynthWithPlugins}/${vapoursynth.python3.sitePackages} \
        --prefix VAPOURSYNTH_CONF_PATH : ${cfgg}
  '';

in
  withPlugins []
