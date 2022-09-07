{ lib, fetchFromGitHub, runCommand, makeWrapper, rustPlatform, gtk3, glib, vapoursynth, pkg-config, xorg, libGL }:
let
  #adapted from https://github.com/NixOS/nixpkgs/blob/nixos-22.05/pkgs/development/libraries/vapoursynth/editor.nix
  unwrapped = rustPlatform.buildRustPackage rec {
    pname = "vspreview-rs";
    version = "0.1.2";

    src = fetchFromGitHub {
      owner = "quietvoid";
      repo = pname;
      rev = version;
      sha256 = "sha256-HJS/BPdsWF1QgCy9irwnRMAkU2MFQPbENE9kbOOIfq8=";
    };

    cargoSha256 = "sha256-Y7qhQO15mfIjsKeemTa19DOUFHLS1N1Jv8XyaYY2jT8=";
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [
      gtk3 glib vapoursynth

      #copied from https://github.com/NixOS/nixpkgs/blob/350fd0044447ae8712392c6b212a18bdf2433e71/pkgs/applications/misc/rusty-psn/default.nix
      xorg.libxcb
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      xorg.libxcb
      libGL
      libGL.dev
    ];

    passthru = { inherit withPlugins; };

    postFixup = ''
      patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/bin/vspreview-rs
    '';

    meta = with lib; {
      description = "A VapourSynth script previewer";
      homepage = "https://github.com/quietvoid/vspreview-rs/";
      license = licenses.mit;
      platforms = [ "x86_64-linux" ];
      maintainers = with maintainers; [ AngryAnt ];
    };
  };
  withPlugins = plugins: let
    vapoursynthWithPlugins = vapoursynth.withPlugins plugins;
  in runCommand "${unwrapped.name}-with-plugins" {
    buildInputs = [ makeWrapper ];
    passthru = { withPlugins = plugins': withPlugins (plugins ++ plugins'); };
  } ''
    mkdir -p $out/bin
    makeWrapper ${unwrapped}/bin/vspreview-rs $out/bin/vspreview-rs \
        --prefix PYTHONPATH : ${vapoursynthWithPlugins}/${vapoursynth.python3.sitePackages} \
        --prefix LD_LIBRARY_PATH : ${vapoursynthWithPlugins}/lib
  '';

in
  withPlugins []
