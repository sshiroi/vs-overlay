final: prev:
let
  common = import ./common.nix final prev;
  callPythonPackage = common.callPythonPackage;
  filter_python_plugins = common.filter_python_plugins;
in rec {
    #already in nixpkgs
    ffms2 = prev.ffms;
    mvtools = prev.vapoursynth-mvtools;

    #rust
    adaptivegrain = prev.callPackage ./plugins/adaptivegrain { };
    bdngsp = prev.callPackage ./plugins/bdngsp { };

    #waf
    f3kdb = prev.callPackage ./plugins/f3kdb { };

    #++++++++++++++++can use meson on update++++++++++++++++++++++++++++++++++++
    knlmeanscl = prev.callPackage ./plugins/knlmeanscl { };
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
    imwri = prev.callPackage ./plugins/imwri { };
    vmaf = prev.callPackage ./plugins/vmaf { };
    rife = prev.callPackage ./plugins/rife { ncnn = common.old_ncnn; };

    #meson normal install is correct folder
    beziercurve = prev.callPackage ./plugins/beziercurve { };
    remap = prev.callPackage ./plugins/remap { };


    #cmake
    dhce = prev.callPackage ./plugins/dhce { };
    delogohd = prev.callPackage ./plugins/delogohd { };
    w2xnvk = prev.callPackage ./plugins/w2xnvk { ncnn = common.old_ncnn; glslang = common.old_glslang; };

    #Gnumakefile + diy ./configure
    vaguedenoiser = prev.callPackage ./plugins/vaguedenoiser { };
    IT = prev.callPackage ./plugins/IT { };
    combmask = prev.callPackage ./plugins/combmask { };
    lsmashsource = prev.callPackage ./plugins/lsmashsource { };
    tnlmeans = prev.callPackage ./plugins/tnlmeans { }; # + patchShebangs

    #weird configure/special
    ReduceFlicker = prev.callPackage ./plugins/ReduceFlicker { };
    znedi3 = prev.callPackage ./plugins/znedi3 { };
    realsr = prev.callPackage ./plugins/realsr { ncnn = common.old_ncnn; glslang = common.old_glslang; };
    bilateral = prev.callPackage ./plugins/bilateral { }; # few oddities

    #manual compile
    wwxd = prev.callPackage ./plugins/wwxd { };
    edgefixer = prev.callPackage ./plugins/edgefixer { };
    surfaceblur = prev.callPackage ./plugins/surfaceblur { };
    arearesize = prev.callPackage ./plugins/arearesize { };
    autocrop = prev.callPackage ./plugins/autocrop { };
    continuityfixer = prev.callPackage ./plugins/continuityfixer { };
    dotkill = prev.callPackage ./plugins/dotkill { }; # fixx
    planestatsmod = prev.callPackage ./other/planestatsmod.nix { }; # fixx

    #not a plugin rather a library
    vapoursynth-plusplus = prev.callPackage ./plugins/vapoursynth-plusplus { };

    #single file python gist
    finedehalo = callPythonPackage ./plugins/finedehalo { };

    #overrides
    lsmashsource_akarin = ((prev.callPackage ./plugins/lsmashsource { }).overrideAttrs ( prev: rec {
      nativeBuildInputs = prev.nativeBuildInputs ++ [ final.meson final.ninja ];
      src = final.fetchFromGitHub {
        owner = "c";
        repo = "L-SMASH-Works";
        rev = "e6ea8d9dd569e54e215558520c5efd429de14c62";
        sha256 = "sha256-pO8H2pv8TBAmlIu0bzWy2V6JgjOc2NARyPK6sKi/SLE=";
      };
      postPatch = ''
        substituteInPlace VapourSynth/meson.build \
            --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
      '';
    }));

    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (python-final: python-prev: {
        styler00dollar-vsgan-trt = callPythonPackage ./tools/styler00dollar-vsgan-trt { };
      })
    ];
}