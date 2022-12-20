{ lib, stdenv, autoreconfHook, pkg-config, vapoursynth }:
{ pname,
  version,
  meta,
  src,
  nativeBuildInputs ? [],
  buildInputs ? [],
  #namespace ? "noplugineverhasthisnamespace",
  namespace,
  ...
}@args:
stdenv.mkDerivation (args // {
  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ] ++ nativeBuildInputs;
  buildInputs = [ vapoursynth ] ++ buildInputs;

  doInstallCheck = if namespace != "noplugineverhasthisnamespace" then true else false;
  installCheckPhase =  if namespace != "noplugineverhasthisnamespace" then (vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth namespace) else "";
})