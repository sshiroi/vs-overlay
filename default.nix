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
      format = "other";
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
  #then they fixed it, but now its broken again so this patch stays
  old_ncnn = prev.ncnn.override { glslang = old_glslang; };

in
{
  #example
  #plugin_list = with pkgs.vapoursynthPlugins; [ ... ];
  #vap_with_stubs = (pkgs.vapoursynth.withPlugins (plugin_list ++ [ (pkgs.generate_vapoursynth_stubs plugin_list) ]));
  #pkgs.mkShell { buildInputs = with pkgs; [ vscodium vap_with_stubs.python3 vap_with_stubs ] }
  generate_vapoursynth_stubs = generate_stubs;

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

  vapoursynth = prev.vapoursynth.overrideAttrs (old: rec {
    passthru = (old.passthru) // (rec {  installCheckPhasePluginExistanceCheck = final.vapoursynthInstallCheckPhase; } );
  });


  #todo: look for "getPluginById" in source and  find dependecyies of binary plugins to binary plugins

  vapoursynthPlugins = prev.recurseIntoAttrs {
    adaptivegrain = prev.callPackage ./plugins/adaptivegrain { };
    autocrop = prev.callPackage ./plugins/autocrop { };
    awarpsharp2 = prev.callPackage ./plugins/awarpsharp2 { };

    beziercurve = prev.callPackage ./plugins/beziercurve { };
    bifrost = prev.callPackage ./plugins/bifrost { };
    bilateral = prev.callPackage ./plugins/bilateral { };
    chickendream = prev.callPackage ./plugins/chickendream { };
    combmask = prev.callPackage ./plugins/combmask { };
    continuityfixer = prev.callPackage ./plugins/continuityfixer { };
    d2vsource = prev.callPackage ./plugins/d2vsource { };
    dotkill = prev.callPackage ./plugins/dotkill { };
    f3kdb = prev.callPackage ./plugins/f3kdb { };
    ffms2 = prev.ffms;
    fillborders = prev.callPackage ./plugins/fillborders { };
    fluxsmooth = prev.callPackage ./plugins/fluxsmooth { };
    fmtconv = prev.callPackage ./plugins/fmtconv { };
    hqdn3d = prev.callPackage ./plugins/hqdn3d { };
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
    median = prev.callPackage ./plugins/median { };
    miscfilters-obsolete = prev.callPackage ./plugins/miscfilters-obsolete { };
    msmoosh = prev.callPackage ./plugins/msmoosh { };
    mvtools = prev.vapoursynth-mvtools;
    mvtools-sf = prev.callPackage ./plugins/mvtools-sf { };
    nnedi3 = prev.callPackage ./plugins/nnedi3 { };
    remap = prev.callPackage ./plugins/remap { };
    sangnom = prev.callPackage ./plugins/sangnom { };
    scxvid = prev.callPackage ./plugins/scxvid { };
    tivtc = prev.callPackage ./plugins/tivtc { };
    tnlmeans = prev.callPackage ./plugins/tnlmeans { };
    znedi3 = prev.callPackage ./plugins/znedi3 { };
    w2xnvk = prev.callPackage ./plugins/w2xnvk { ncnn = old_ncnn; glslang = old_glslang; };
    rife = prev.callPackage ./plugins/rife { ncnn = old_ncnn; };
    realsr = prev.callPackage ./plugins/realsr { ncnn = old_ncnn; glslang = old_glslang; };
    fieldhint = prev.callPackage ./plugins/fieldhint { };
    bdngsp = prev.callPackage ./plugins/bdngsp { };
    vstrt = prev.callPackage ./plugins/vstrt { };


    #multi python binary stuff
    descale = prev.callPackage ./plugins/descale { };
    ccd = prev.callPackage ./plugins/ccd { };


    #meson lto
    tcanny = prev.callPackage ./plugins/tcanny { };
    bwdif = prev.callPackage ./plugins/bwdif { };
    ttempsmooth = prev.callPackage ./plugins/ttempsmooth { };
    addgrain = prev.callPackage ./plugins/addgrain { };
    readmpls = prev.callPackage ./plugins/readmpls { };


    #meson subsinplace other
    imwri = prev.callPackage ./plugins/imwri { };
    vmaf = prev.callPackage ./plugins/vmaf { };


    # meson vapoursynth_dep.get_pkgconfig_variable('libdir')
    deblock = prev.callPackage ./plugins/deblock { };
    bm3d = prev.callPackage ./plugins/bm3d { };
    lghost = prev.callPackage ./plugins/lghost { };
    bestsource = prev.callPackage ./plugins/bestsource { };
    akarin = prev.callPackage ./plugins/akarin { };
    cas = prev.callPackage ./plugins/cas { };
    ctmf = prev.callPackage ./plugins/ctmf { };
    tcolormask = prev.callPackage ./plugins/tcolormask { };
    dctfilter = prev.callPackage ./plugins/dctfilter { };
    dfttest = prev.callPackage ./plugins/dfttest { };
    eedi2 = prev.callPackage ./plugins/eedi2 { };
    eedi3m = prev.callPackage ./plugins/eedi3m { };
    fft3dfilter = prev.callPackage ./plugins/fft3dfilter { };
    libp2p = prev.callPackage ./plugins/libp2p { };
    nnedi3cl = prev.callPackage ./plugins/nnedi3cl { };
    ocr = prev.callPackage ./plugins/ocr { };
    placebo = prev.callPackage ./plugins/placebo { };
    removegrain = prev.callPackage ./plugins/removegrain { };
    retinex = prev.callPackage ./plugins/retinex { };
    subtext = prev.callPackage ./plugins/subtext { };
    tdeintmod = prev.callPackage ./plugins/tdeintmod { };
    vivtc = prev.callPackage ./plugins/vivtc { };
    vsrawsource = prev.callPackage ./plugins/vsrawsource { };
    dpid = prev.callPackage ./plugins/dpid { };
    fftspectrum = prev.callPackage ./plugins/fftspectrum { };
    deblockpp7 = prev.callPackage ./plugins/deblockpp7 { };



    #meson mesonFlags
    tedgemask = prev.callPackage ./plugins/tedgemask { };
    decross = prev.callPackage ./plugins/decross { };
    asharp = prev.callPackage ./plugins/asharp { };
    temporalmedian = prev.callPackage ./plugins/temporalmedian { };
    tbilateral = prev.callPackage ./plugins/tbilateral { };
    vfrtocfr = prev.callPackage ./plugins/vfrtocfr { };
    vcm = prev.callPackage ./plugins/vcm { };
    fix-telecined-fades = prev.callPackage ./plugins/fix-telecined-fades { };
    temporalsoften2 = prev.callPackage ./plugins/temporalsoften2 { };
    motionmask = prev.callPackage ./plugins/motionmask { };
    minideen = prev.callPackage ./plugins/minideen { };
    cmedian = prev.callPackage ./plugins/cmedian { };
    tcomb = prev.callPackage ./plugins/tcomb { };
    dedot = prev.callPackage ./plugins/dedot { };
    matchhistogram = prev.callPackage ./plugins/matchhistogram { };
    smoothuv = prev.callPackage ./plugins/smoothuv { };
    frfun7 = prev.callPackage ./plugins/frfun7 { };

    #cmake
    dhce = prev.callPackage ./plugins/dhce { };
    delogohd = prev.callPackage ./plugins/delogohd { };

    #automake
    cnr2 = prev.callPackage ./plugins/cnr2 { };
    degrainmedian = prev.callPackage ./plugins/degrainmedian { };
    colorbars = prev.callPackage ./plugins/colorbars { };
    ssiq = prev.callPackage ./plugins/ssiq { };
    histogram = prev.callPackage ./plugins/histogram { };
    tonemap = prev.callPackage ./plugins/tonemap { };

    #Gnumakefile + diy ./configure
    vaguedenoiser = prev.callPackage ./plugins/vaguedenoiser { };
    IT = prev.callPackage ./plugins/IT { };

    #weird configure
    ReduceFlicker = prev.callPackage ./plugins/ReduceFlicker { };


    #manual compile
    wwxd = prev.callPackage ./plugins/wwxd { };
    edgefixer = prev.callPackage ./plugins/edgefixer { };
    surfaceblur = prev.callPackage ./plugins/surfaceblur { };
    arearesize = prev.callPackage ./plugins/arearesize { };


    #not a plugin rather a library
    vapoursynth-plusplus = prev.callPackage ./plugins/vapoursynth-plusplus { };


    acsuite = callPythonPackage ./plugins/acsuite { };
    adjust = callPythonPackage ./plugins/adjust { };
    debandshit = callPythonPackage ./plugins/debandshit { };
    edi_rpow2 = callPythonPackage ./plugins/edi_rpow2 { };
    mt_lutspa = callPythonPackage ./plugins/mt_lutspa { };
    nnedi3_resample = callPythonPackage ./plugins/nnedi3_resample { };
    nnedi3_rpow2 = callPythonPackage ./plugins/nnedi3_rpow2 { };
    rekt = callPythonPackage ./plugins/rekt { };
    vsgan = callPythonPackage ./plugins/vsgan { };
    vsTAAmbk = callPythonPackage ./plugins/vsTAAmbk { inherit filter_python_plugins; };
    vsutil = callPythonPackage ./plugins/vsutil { };

    vs-dfft = callPythonPackage ./plugins/vs-dfft { };

    #Irrational-Encoding-Wizardry
    vs-rgtools = callPythonPackage ./plugins/vs-rgtools { };
    vs-exprtools = callPythonPackage ./plugins/vs-exprtools { };
    vs-kernels = callPythonPackage ./plugins/vs-kernels { };
    vs-parsedvd = callPythonPackage ./plugins/vs-parsedvd { };
    vs-tools = callPythonPackage ./plugins/vs-tools { };
    vsmask = callPythonPackage ./plugins/vsmask { };
    vs-dehalo = callPythonPackage ./plugins/vs-dehalo { };
    vs-denoise = callPythonPackage ./plugins/vs-denoise { };
    vs-aa = callPythonPackage ./plugins/vs-aa { inherit filter_python_plugins;  };
    vs-scale = callPythonPackage ./plugins/vs-scale { };
    hysteria = callPythonPackage ./plugins/hysteria { };

    #*func
    awsmfunc = callPythonPackage ./plugins/awsmfunc { };
    fvsfunc = callPythonPackage ./plugins/fvsfunc { };
    havsfunc = callPythonPackage ./plugins/havsfunc { inherit filter_python_plugins; };
    kagefunc = callPythonPackage ./plugins/kagefunc { };
    lvsfunc = callPythonPackage ./plugins/lvsfunc { };
    muvsfunc = callPythonPackage ./plugins/muvsfunc { };
    mvsfunc = callPythonPackage ./plugins/mvsfunc { };
    vardefunc = callPythonPackage ./plugins/vardefunc { };
    zzfunc = callPythonPackage ./plugins/zzfunc { };

    #single file python stuff
    Vine = callPythonPackage ./plugins/Vine { };
    Plum = callPythonPackage ./plugins/Plum { };
    atomchtools = callPythonPackage ./plugins/atomchtools { };
    cooldegrain = callPythonPackage ./plugins/atomchtools/cooldegrain.nix { };
    Oyster = callPythonPackage ./plugins/Oyster { };
    astdr = callPythonPackage ./plugins/astdr { };
    dfmderainbow = callPythonPackage ./plugins/dfmderainbow { };
    maskdetail = callPythonPackage ./plugins/maskdetail { };
    xaa = callPythonPackage ./plugins/xaa { };
    wss = callPythonPackage ./plugins/wss { };

    #single file python gist
    finedehalo = callPythonPackage ./plugins/finedehalo { };
  };

  getnative = callPythonPackage ./tools/getnative { };
  vspreview-rs = prev.callPackage ./tools/vspreview-rs { };
  d2vwitch = prev.libsForQt5.callPackage ./tools/d2vwitch { };
  wobbly = prev.libsForQt5.callPackage ./tools/wobbly { };
  vspreview = callPythonPackage ./tools/vspreview { python_call = callPythonPackage; };
  concatfs = prev.callPackage ./tools/concatfs { }; #maybe useful for vob files

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

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      styler00dollar-vsgan-trt = callPythonPackage ./tools/styler00dollar-vsgan-trt { };
    })
  ];

}
