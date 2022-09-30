final: prev:
let
  # This is required to allow vapoursynth.withPlugins to be used inside python packages,
  # where normally python3Packages.vapoursynth would be used,
  # which only includes the python module without the frameserver.
  callPythonPackage = prev.lib.callPackageWith (final // final.vapoursynth.python3.pkgs // {
    inherit (final) vapoursynth;
  });

  filter_python_plugins = plugins: (builtins.filter (a: !(builtins.hasAttr "isBuildPythonPackage" a.meta)) plugins);

  generate_stubs = plg: let
    vap = final.vapoursynth.withPlugins plg;
  in
    final.vapoursynth.python3.pkgs.buildPythonPackage {
      name = "vapoursynth-stubs";
      phases = [ "buildPhase" "installPhase" ];

      nativeBuildInputs = [
        vap.python3
        (callPythonPackage ./tools/vsstubs { })
        #(callPythonPackage ./tools/vsstubs { vapoursynth = vap; })
        vap
      ];

      buildPhase = ''
      PYTHONPATH=${vap}/${vap.python3.sitePackages}:$PYTHONPATH
      python -m vsstubs install test
      '';

      installPhase = ''
      install -D /build/vapoursynth.pyi $out/${vap.python3.sitePackages}/vapoursynth.pyi
      '';
    };

  old_glslang = prev.glslang.overrideAttrs (old: rec {
    version = "1.3.216.0";
    src = prev.fetchFromGitHub {
      owner = "KhronosGroup";
      repo = "glslang";
      rev ="sdk-${version}";
      hash = "sha256-sjidkiPtRADhyOEKDb2cHCBXnFjLwk2F5Lppv5/fwNQ=";
    };
  });
  #latest nixos-unstable has broken ncnn because some glslang update
  old_ncnn = prev.ncnn.override { glslang = old_glslang; };
in
{
  #example
  #plugin_list = with pkgs.vapoursynthPlugins; [ ... ];
  #vap_with_stubs = (pkgs.vapoursynth.withPlugins (plugin_list ++ [ (pkgs.generate_vapoursynth_stubs plugin_list) ]));
  #pkgs.mkShell { buildInputs = with pkgs; [ vscodium vap_with_stubs.python3 vap_with_stubs ] }
  generate_vapoursynth_stubs = generate_stubs;

  vapoursynth = prev.vapoursynth.overrideAttrs (old: rec {
    version = "60";
    src = prev.fetchFromGitHub {
      owner  = "vapoursynth";
      repo   = "vapoursynth";
      rev    = "R${version}";
      sha256 = "sha256-E1uHNcGxBrwg00tNnY3qH6BpvXtBEGkX7QFy0aMLSnA=";
    };
  });


  ncnn = old_ncnn;
  glslang = old_glslang;

  vapoursynthPlugins = prev.recurseIntoAttrs {
    akarin = prev.callPackage ./plugins/akarin { };
    adaptivegrain = prev.callPackage ./plugins/adaptivegrain { };
    addgrain = prev.callPackage ./plugins/addgrain { };
    autocrop = prev.callPackage ./plugins/autocrop { };
    awarpsharp2 = prev.callPackage ./plugins/awarpsharp2 { };
    bestaudiosource = prev.callPackage ./plugins/bestaudiosource { };
    bestsource = prev.callPackage ./plugins/bestsource { };
    beziercurve = prev.callPackage ./plugins/beziercurve { };
    bifrost = prev.callPackage ./plugins/bifrost { };
    bilateral = prev.callPackage ./plugins/bilateral { };
    bm3d = prev.callPackage ./plugins/bm3d { };
    cas = prev.callPackage ./plugins/cas { };
    chickendream = prev.callPackage ./plugins/chickendream { };
    cnr2 = prev.callPackage ./plugins/cnr2 { };
    combmask = prev.callPackage ./plugins/combmask { };
    continuityfixer = prev.callPackage ./plugins/continuityfixer { };
    ctmf = prev.callPackage ./plugins/ctmf { };
    d2vsource = prev.callPackage ./plugins/d2vsource { };
    dctfilter = prev.callPackage ./plugins/dctfilter { };
    deblock = prev.callPackage ./plugins/deblock { };
    descale = prev.callPackage ./plugins/descale { };
    dfttest = prev.callPackage ./plugins/dfttest { };
    dotkill = prev.callPackage ./plugins/dotkill { };
    eedi2 = prev.callPackage ./plugins/eedi2 { };
    eedi3m = prev.callPackage ./plugins/eedi3m { };
    f3kdb = prev.callPackage ./plugins/f3kdb { };
    ffms2 = prev.ffms;
    fft3dfilter = prev.callPackage ./plugins/fft3dfilter { };
    fillborders = prev.callPackage ./plugins/fillborders { };
    fluxsmooth = prev.callPackage ./plugins/fluxsmooth { };
    fmtconv = prev.callPackage ./plugins/fmtconv { };
    histogram = prev.callPackage ./plugins/histogram { };
    hqdn3d = prev.callPackage ./plugins/hqdn3d { };
    imwri = prev.callPackage ./plugins/imwri { };
    knlmeanscl = prev.callPackage ./plugins/knlmeanscl { };
    lsmashsource = prev.callPackage ./plugins/lsmashsource { };
    lsmashsource_akarin = ((prev.callPackage ./plugins/lsmashsource { }).overrideAttrs ( prev: rec {
      nativeBuildInputs = prev.nativeBuildInputs ++ [ final.meson final.ninja ];
      src = final.fetchFromGitHub {
        owner = "AkarinVS";
        repo = "L-SMASH-Works";
        rev = "e6ea8d9dd569e54e215558520c5efd429de14c62";
        sha256 = "sha256-pO8H2pv8TBAmlIu0bzWy2V6JgjOc2NARyPK6sKi/SLE=";
      };
      postPatch = ''
        substituteInPlace VapourSynth/meson.build \
            --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
      '';
    }));
    libp2p = prev.callPackage ./plugins/libp2p { };
    median = prev.callPackage ./plugins/median { };
    miscfilters-obsolete = prev.callPackage ./plugins/miscfilters-obsolete { };
    msmoosh = prev.callPackage ./plugins/msmoosh { };
    mvtools = prev.vapoursynth-mvtools;
    nnedi3 = prev.callPackage ./plugins/nnedi3 { };
    nnedi3cl = prev.callPackage ./plugins/nnedi3cl { };
    ocr = prev.callPackage ./plugins/ocr { };
    placebo = prev.callPackage ./plugins/placebo { };
    readmpls = prev.callPackage ./plugins/readmpls { };
    remap = prev.callPackage ./plugins/remap { };
    removegrain = prev.callPackage ./plugins/removegrain { };
    retinex = prev.callPackage ./plugins/retinex { };
    sangnom = prev.callPackage ./plugins/sangnom { };
    scxvid = prev.callPackage ./plugins/scxvid { };
    subtext = prev.callPackage ./plugins/subtext { };
    tcanny = prev.callPackage ./plugins/tcanny { };
    tivtc = prev.callPackage ./plugins/tivtc { };
    tdeintmod = prev.callPackage ./plugins/tdeintmod { };
    tnlmeans = prev.callPackage ./plugins/tnlmeans { };
    ttempsmooth = prev.callPackage ./plugins/ttempsmooth { };
    vivtc = prev.callPackage ./plugins/vivtc { };
    wwxd = prev.callPackage ./plugins/wwxd { };
    znedi3 = prev.callPackage ./plugins/znedi3 { };
    w2xnvk = prev.callPackage ./plugins/w2xnvk { };
    rife = prev.callPackage ./plugins/rife { };
    realsr = prev.callPackage ./plugins/realsr { };
    dhce = prev.callPackage ./plugins/dhce { };
    fieldhint = prev.callPackage ./plugins/fieldhint { };
    bdngsp = prev.callPackage ./plugins/bdngsp { };


    acsuite = callPythonPackage ./plugins/acsuite { };
    adjust = callPythonPackage ./plugins/adjust { };
    debandshit = callPythonPackage ./plugins/debandshit { };
    edi_rpow2 = callPythonPackage ./plugins/edi_rpow2 { };
    finedehalo = callPythonPackage ./plugins/finedehalo { };
    mt_lutspa = callPythonPackage ./plugins/mt_lutspa { };
    nnedi3_resample = callPythonPackage ./plugins/nnedi3_resample { };
    nnedi3_rpow2 = callPythonPackage ./plugins/nnedi3_rpow2 { };
    rekt = callPythonPackage ./plugins/rekt { };
    vsgan = callPythonPackage ./plugins/vsgan { };
    vsTAAmbk = callPythonPackage ./plugins/vsTAAmbk { inherit filter_python_plugins; };
    vsutil = callPythonPackage ./plugins/vsutil { };
    vs-dfft = callPythonPackage ./plugins/vs-dfft { };
    vs-rgtools = callPythonPackage ./plugins/vs-rgtools { };
    vs-exprtools = callPythonPackage ./plugins/vs-exprtools { };
    vs-kernels = callPythonPackage ./plugins/vs-kernels { };
    vs-parsedvd = callPythonPackage ./plugins/vs-parsedvd { };
    hysteria = callPythonPackage ./plugins/hysteria { };

    awsmfunc = callPythonPackage ./plugins/awsmfunc { };
    fvsfunc = callPythonPackage ./plugins/fvsfunc { };
    havsfunc = callPythonPackage ./plugins/havsfunc { inherit filter_python_plugins; };
    kagefunc = callPythonPackage ./plugins/kagefunc { };
    lvsfunc = callPythonPackage ./plugins/lvsfunc { };
    muvsfunc = callPythonPackage ./plugins/muvsfunc { };
    mvsfunc = callPythonPackage ./plugins/mvsfunc { };
    vardefunc = callPythonPackage ./plugins/vardefunc { };
    zzfunc = callPythonPackage ./plugins/zzfunc { };
  };

  getnative = callPythonPackage ./tools/getnative { };
  vspreview-rs = prev.callPackage ./tools/vspreview-rs { };
  d2vwitch = prev.libsForQt5.callPackage ./tools/d2vwitch { };
  wobbly = prev.libsForQt5.callPackage ./tools/wobbly { };
  vspreview = callPythonPackage ./tools/vspreview { python_call = callPythonPackage; };

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
