{ writeText, runCommand, buildEnv }:
plugins:
let
  collected_plugins = buildEnv {
    name = "vapoursynth-plugins-env";
    pathsToLink = [ "/lib/vapoursynth" ];
    paths = plugins;
  };
in
  #for use with VAPOURSYNTH_CONF_PATH
  writeText "vapoursynth.conf" ''
  UserPluginDir=${collected_plugins}/lib/vapoursynth
  AutoloadUserPluginDir=true
  ''