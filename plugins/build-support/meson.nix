{ stdenv, vapoursynth, meson, ninja, pkg-config }:
{ pname,
  version,
  meta,
  src,
  nativeBuildInputs ? [],
  mesonFlags ? [],
  buildInputs ? [],
  postPatch ?  "",
  #namespace ? "noplugineverhasthisnamespace",
  namespace,
  mode,

  install_dir_vapoursynth_added_in_meson ? false,#mode a

  modeb_replace ?  "vapoursynth_dep.get_pkgconfig_variable('libdir')",
  ...
}@args:
stdenv.mkDerivation (args // {
  mesonFlags = if mode == "B" then
    mesonFlags
  else
   ([(if install_dir_vapoursynth_added_in_meson then
      "--libdir=${placeholder "out"}/lib/"
    else
      "--libdir=${placeholder "out"}/lib/vapoursynth"
    )] ++ mesonFlags);

  doInstallCheck = if namespace != "noplugineverhasthisnamespace" then true else false;
  installCheckPhase =  if namespace != "noplugineverhasthisnamespace" then (vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth namespace) else "";

  nativeBuildInputs = [ meson ninja pkg-config ]  ++ nativeBuildInputs;
  buildInputs = [ vapoursynth ]  ++ buildInputs;


  postPatch = if mode == "B" then (''

    substituteInPlace meson.build --replace "${modeb_replace}" "get_option('libdir')"

  '' + postPatch) else postPatch;

})