{ writeText, runCommand, buildEnv }:
plugins:
let
  collected_plugins = buildEnv {
    name = "vapoursynth-plugins-env";
    pathsToLink = [ "/lib/vapoursynth" ];
    paths = plugins;
  };
in
  writeText "vapoursynth.conf" "UserPluginDir=${collected_plugins}/lib/vapoursynth"