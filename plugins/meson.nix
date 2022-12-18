final: prev:
let
  common = import ../common.nix final prev;
in rec {
    #meson A
    tedgemask           = prev.callPackage ./mesonA/tedgemask.nix { };
    decross             = prev.callPackage ./mesonA/decross.nix { };
    asharp              = prev.callPackage ./mesonA/asharp.nix { };
    temporalmedian      = prev.callPackage ./mesonA/temporalmedian.nix { };
    tbilateral          = prev.callPackage ./mesonA/tbilateral.nix { };
    vcm                 = prev.callPackage ./mesonA/vcm.nix { };
    temporalsoften2     = prev.callPackage ./mesonA/temporalsoften2.nix { };
    motionmask          = prev.callPackage ./mesonA/motionmask.nix { };
    minideen            = prev.callPackage ./mesonA/minideen.nix { };
    cmedian             = prev.callPackage ./mesonA/cmedian.nix { };
    tcomb               = prev.callPackage ./mesonA/tcomb.nix { };
    dedot               = prev.callPackage ./mesonA/dedot.nix { };
    matchhistogram      = prev.callPackage ./mesonA/matchhistogram.nix { };
    smoothuv            = prev.callPackage ./mesonA/smoothuv.nix { };
    frfun7              = prev.callPackage ./mesonA/frfun7.nix { };
    awarpsharp2         = prev.callPackage ./mesonA/awarpsharp2.nix { };
    fillborders         = prev.callPackage ./mesonA/fillborders.nix { };
    median              = prev.callPackage ./mesonA/median.nix { };
    sangnom             = prev.callPackage ./mesonA/sangnom.nix { };
    tivtc               = prev.callPackage ./mesonA/tivtc.nix { };

    vfrtocfr            = prev.callPackage ./mesonA/vfrtocfr.nix { };
    fix-telecined-fades = prev.callPackage ./mesonA/fix-telecined-fades.nix { };


    #meson b
    deblock              = prev.callPackage ./mesonB/deblock.nix { };
    miscfilters-obsolete = prev.callPackage ./mesonB/miscfilters-obsolete.nix { }; # but dep.get_pkgconfig....
    bm3d                 = prev.callPackage ./mesonB/bm3d.nix { };
    lghost               = prev.callPackage ./mesonB/lghost.nix { };
    bestsource           = prev.callPackage ./mesonB/bestsource.nix { };
    akarin               = prev.callPackage ./mesonB/akarin.nix { };
    cas                  = prev.callPackage ./mesonB/cas.nix { };
    ctmf                 = prev.callPackage ./mesonB/ctmf.nix { };
    tcolormask           = prev.callPackage ./mesonB/tcolormask.nix { };
    dctfilter            = prev.callPackage ./mesonB/dctfilter.nix { };
    dfttest              = prev.callPackage ./mesonB/dfttest.nix { };
    eedi2                = prev.callPackage ./mesonB/eedi2.nix { };
    eedi3m               = prev.callPackage ./mesonB/eedi3m.nix { };
    fft3dfilter          = prev.callPackage ./mesonB/fft3dfilter.nix { };
    libp2p               = prev.callPackage ./mesonB/libp2p.nix { };
    nnedi3cl             = prev.callPackage ./mesonB/nnedi3cl.nix { };
    ocr                  = prev.callPackage ./mesonB/ocr.nix { };
    placebo              = prev.callPackage ./mesonB/placebo.nix { };
    removegrain          = prev.callPackage ./mesonB/removegrain.nix { };
    retinex              = prev.callPackage ./mesonB/retinex.nix { };
    subtext              = prev.callPackage ./mesonB/subtext.nix { };
    tdeintmod            = prev.callPackage ./mesonB/tdeintmod.nix { };
    vivtc                = prev.callPackage ./mesonB/vivtc.nix { };
    vsrawsource          = prev.callPackage ./mesonB/vsrawsource.nix { };
    dpid                 = prev.callPackage ./mesonB/dpid.nix { };
    fftspectrum          = prev.callPackage ./mesonB/fftspectrum.nix { };
    deblockpp7           = prev.callPackage ./mesonB/deblockpp7.nix { };
    mvtools-sf           = prev.callPackage ./mesonB/mvtools-sf.nix { };# but vs.get_pkgconfig....



    #meson C (lto)
    bwdif        = prev.callPackage ./mesonC/bwdif.nix { };
    ttempsmooth  = prev.callPackage ./mesonC/ttempsmooth.nix { };
    addgrain     = prev.callPackage ./mesonC/addgrain.nix { };
    readmpls     = prev.callPackage ./mesonC/readmpls.nix { };
    imwri        = prev.callPackage ./mesonC/imwri.nix { };
    vmaf         = prev.callPackage ./mesonC/vmaf.nix { };
    rife         = prev.callPackage ./mesonC/rife.nix { ncnn = common.old_ncnn; };

    #tcanny is weird because it needs clangstdenv ???
    tcanny       = prev.callPackage ./other/tcanny.nix { };


}
