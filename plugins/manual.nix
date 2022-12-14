prev: final: rec {
  #manual compile
  wwxd            = prev.callPackage ./manual/wwxd.nix { };
  edgefixer       = prev.callPackage ./manual/edgefixer { };
  surfaceblur     = prev.callPackage ./manual/surfaceblur.nix { };
  arearesize      = prev.callPackage ./manual/arearesize.nix { };
  autocrop        = prev.callPackage ./manual/autocrop.nix { };
  continuityfixer = prev.callPackage ./manual/continuityfixer.nix { };
  dotkill         = prev.callPackage ./manual/dotkill.nix { }; # fixx
  planestatsmod   = prev.callPackage ./manual/planestatsmod.nix { }; # fixx
}