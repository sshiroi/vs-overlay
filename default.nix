final: prev:
let
  common = import ./plugins/common.nix final prev;
  filter_python_plugins = common.filter_python_plugins;
in
{
  #example
  #plugin_list = with pkgs.vapoursynthPlugins; [ ... ];
  #vap_with_stubs = (pkgs.vapoursynth.withPlugins (plugin_list ++ [ (pkgs.generate_vapoursynth_stubs plugin_list) ]));
  #pkgs.mkShell { buildInputs = with pkgs; [ vscodium vap_with_stubs.python3 vap_with_stubs ] }
  generate_vapoursynth_stubs = common.generate_stubs;


  mkVapoursynthMeson = prev.callPackage ./plugins/build-support/meson.nix {};
  mkVapoursynthMesonA = attrs: final.mkVapoursynthMeson ( attrs // {
    mode = "A";
  });
  mkVapoursynthMesonB = attrs: final.mkVapoursynthMeson ( attrs // {
    mode = "B";
  });

  mkVapoursynthAutomake = prev.callPackage ./plugins/build-support/automake.nix {};
  mkVapoursynthPython = common.callPythonPackage ./plugins/build-support/pythonfunc_singlefile.nix { inherit filter_python_plugins; };
  mkVapoursynthPythonSinglefileFunc = attrs: final.mkVapoursynthPython ( attrs // { format = "other"; });
  mkVapoursynthPythonSetuptools = attrs: (final.mkVapoursynthPython) ( attrs // { format = "setuptools"; });
  mkVapoursynthPythonPyproject  = attrs: (final.mkVapoursynthPython) ( attrs // { format = "pyproject"; });




  vapoursynthInstallCheckPhase = vap: namespace: ''
#or loop manually and std.LoadPlugin
echo "UserPluginDir=$out/lib/vapoursynth" > test.conf
VAPOURSYNTH_CONF_PATH=test.conf PYTHONPATH=${vap}/${vap.python3.sitePackages}:$PYTHONPATH ${vap.python3}/bin/python -c '
import vapoursynth
import sys
to_srch = "${namespace}"
fnd= False
for a in vapoursynth.core.plugins():
  print("Got module: {} {}".format(a.namespace,a.name))
  if a.namespace == to_srch:
    print("GOT module break;")
    fnd = True
    break
if fnd == False:
  print("Could not find {}".format(to_srch))
  sys.exit(1)
'
'';



  #todo: look for "getPluginById" in source and  find dependecyies of binary plugins to binary plugins
    vapoursynth = (prev.callPackage ./vapoursynth {
       ApplicationServices = prev.ApplicationServices;
    }).overrideAttrs (old: rec {
    passthru = (old.passthru) // (rec {  installCheckPhasePluginExistanceCheck = final.vapoursynthInstallCheckPhase; } );
  });

  vapoursynthPlugins = prev.recurseIntoAttrs (
       (import ./plugins/automake.nix final prev)
    // (import ./plugins/meson.nix final prev)
    // (import ./plugins/python.nix final prev)
    // (import ./plugins/manual.nix final prev)
    // (import ./plugins/other.nix final prev)
    );

  #tools
  getnative = common.callPythonPackage ./tools/getnative { };
  vspreview-rs = prev.callPackage ./tools/vspreview-rs { };
  d2vwitch = prev.libsForQt5.callPackage ./tools/d2vwitch { };
  wobbly = prev.libsForQt5.callPackage ./tools/wobbly { };
  vspreview = common.callPythonPackage ./tools/vspreview { python_call = common.callPythonPackage; };
  concatfs = prev.callPackage ./tools/concatfs { }; #maybe useful for vob files

  #wrappers
  mpv_vs = vap: (final.mpv-unwrapped.override { vapoursynthSupport = true; vapoursynth = vap; });
  mpv_vs_wrapped = vap:
  let
    mpv_simple = (final.mpv_vs final.vapoursynth);
  in
  prev.runCommand "mpv-vapour-with-plugins" {
    buildInputs = [ final.makeWrapper mpv_simple ];
  } ''
    mkdir -p $out/bin
    ln -s ${mpv_simple}/etc $out/etc
    ln -s ${mpv_simple}/lib $out/lib
    ln -s ${mpv_simple}/share $out/share
    makeWrapper ${mpv_simple}/bin/mpv $out/bin/mpv \
        --prefix PYTHONPATH : ${vap}/${vap.python3.sitePackages} \
        --prefix LD_LIBRARY_PATH : ${vap}/lib
    makeWrapper ${mpv_simple}/bin/umpv $out/bin/umpv \
        --prefix PYTHONPATH : ${vap}/${vap.python3.sitePackages} \
        --prefix LD_LIBRARY_PATH : ${vap}/lib
  '';


}
