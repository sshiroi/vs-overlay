{ lib, stdenv, buildPythonPackage, python, vapoursynth, filter_python_plugins }:
{ pname,
  version,
  meta,
  src,

  propagatedBuildInputs ? [],
  postPatch ? "",
  doCheck ? true,

  checkPhase ? "",
  nativeCheckInputs ? [],
  checkInputs ? [],

  installPhase ? "",
  pythonImportsCheck ? [],

  #custom stuff
  vs_pythondeps,
  vs_binarydeps,
  importname,

  format,

  ...
}@args:
let

  #https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/libraries/vapoursynth/plugin-interface.nix
  getRecursivePropagatedBuildInputs = pkgs: lib.flatten
    (map
      (pkg: let cleanPropagatedBuildInputs = lib.filter lib.isDerivation pkg.propagatedBuildInputs;
        in cleanPropagatedBuildInputs ++ (getRecursivePropagatedBuildInputs cleanPropagatedBuildInputs))
      pkgs);

  deepPlugins = plugins: filter_python_plugins (lib.unique (plugins ++ (getRecursivePropagatedBuildInputs plugins)));

  all_prop = vs_pythondeps ++ vs_binarydeps ++ propagatedBuildInputs;

in
buildPythonPackage (args // {
  propagatedBuildInputs = all_prop;

  format = format;

  installPhase = if format == "other" then ''
    runHook preInstall
    install -D ${importname}.py $out/${python.sitePackages}/${importname}.py
    runHook postInstall
  '' else installPhase;

  postPatch = ''
  if [ -f "requirements.txt" ]; then
      substituteInPlace requirements.txt --replace "VapourSynth>=45" ""
      substituteInPlace requirements.txt --replace "VapourSynth>=51" ""
      substituteInPlace requirements.txt --replace "VapourSynth>=60" ""
      substituteInPlace requirements.txt --replace "VapourSynth>=59" ""
      substituteInPlace requirements.txt --replace "VapourSynth>=61" ""
      substituteInPlace requirements.txt --replace "VapourSynth>=62" ""
      substituteInPlace requirements.txt --replace "VapourSynth>=63" ""
  fi
  if [ -f "setup.py" ]; then
      substituteInPlace setup.py --replace 'VapourSynth>=57' ""
  fi
  '' + postPatch;


  nativeCheckInputs = nativeCheckInputs;
  #TODO: recursion
  checkInputs = [ (vapoursynth.withPlugins2 (deepPlugins (all_prop))) ] ++ checkInputs;

  checkPhase = if !doCheck then "" else ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '' + checkPhase;
  pythonImportsCheck = (if !doCheck then [] else [ importname ]) ++ pythonImportsCheck;
})
