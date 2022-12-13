{ lib, stdenv, buildPythonPackage, python, vapoursynth, filter_python_plugins }:
{ pname,
  version,
  meta,
  src,

  propagatedBuildInputs ? [],
  postPatch ? "",

  checkPhase ? "",
  checkInputs ? [],

  #custom stuff
  vs_pythondeps,
  vs_binarydeps,
  importname,


  remove_vapoursynth_dep_reqtxt ? 0,
  remove_vapoursynth_dep_setupy ? 0,

  ...
}@args:
buildPythonPackage (args // {
  propagatedBuildInputs = vs_pythondeps ++ vs_binarydeps ++ propagatedBuildInputs;

  format = "other";

  installPhase = ''
    runHook preInstall
    install -D ${importname}.py $out/${python.sitePackages}/${importname}.py
    runHook postInstall
  '';

  postPatch =
  (if remove_vapoursynth_dep_reqtxt != 0 then ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=${toString remove_vapoursynth_dep_reqtxt}" ""
  '' else "") +
  (if remove_vapoursynth_dep_setupy != 0 then ''
    substituteInPlace setup.py \
        --replace "VapourSynth>=${toString remove_vapoursynth_dep_setupy}" ""
  '' else "") + postPatch;

  #TODO: recursion
  checkInputs = [ (vapoursynth.withPlugins (filter_python_plugins (vs_pythondeps ++ vs_binarydeps ++ propagatedBuildInputs))) ] ++ checkInputs;
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '' + checkPhase;
  pythonImportsCheck = [ importname ];
})
