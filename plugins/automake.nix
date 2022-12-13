final: prev:
rec {
  cnr2           = prev.callPackage ./automake/cnr2.nix { };
  colorbars      = prev.callPackage ./automake/colorbars.nix { };
  degrainmedian  = prev.callPackage ./automake/degrainmedian.nix { };
  ssiq           = prev.callPackage ./automake/ssiq.nix { };
  histogram      = prev.callPackage ./automake/histogram.nix { };
  tonemap        = prev.callPackage ./automake/tonemap.nix { };
  bifrost        = prev.callPackage ./automake/bifrost.nix { };
  d2vsource      = prev.callPackage ./automake/d2vsource.nix { };
  fluxsmooth     = prev.callPackage ./automake/fluxsmooth.nix { };
  hqdn3d         = prev.callPackage ./automake/hqdn3d.nix { };
  nnedi3         = prev.callPackage ./automake/nnedi3.nix { };
  fieldhint      = prev.callPackage ./automake/fieldhint.nix { };
  scxvid         = prev.callPackage ./automake/scxvid.nix { };
  msmoosh        = prev.callPackage ./automake/msmoosh.nix { };
  fmtconv        = prev.callPackage ./automake/fmtconv.nix { }; # sourceroot
  chickendream   = prev.callPackage ./automake/chickendream.nix { }; # sourceroot
}