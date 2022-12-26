{ writeText, runCommand, buildEnv, lib }:
plugins:
let
  #TOOD: don't copy paste this functions
  getRecursivePropagatedBuildInputs = pkgs: lib.flatten
    (map
      (pkg: let cleanPropagatedBuildInputs = lib.filter lib.isDerivation pkg.propagatedBuildInputs;
        in cleanPropagatedBuildInputs ++ (getRecursivePropagatedBuildInputs cleanPropagatedBuildInputs))
      pkgs);

  deepPlugins = lib.unique (plugins ++ (getRecursivePropagatedBuildInputs plugins));


  collected_plugins = buildEnv {
    name = "vapoursynth-plugins-env";
    pathsToLink = [ "/lib/vapoursynth" ];
    paths = deepPlugins;
  };
in
  #for use with VAPOURSYNTH_CONF_PATH
  writeText "vapoursynth.conf" ''
  UserPluginDir=${collected_plugins}/lib/vapoursynth
  AutoloadUserPluginDir=true
  ''