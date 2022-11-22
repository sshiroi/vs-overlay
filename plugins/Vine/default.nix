{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

buildPythonPackage rec {
  pname = "Vine";
  version = "unstable-2022-10-30";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "b8285e8d17f020bdae8ab722dbf33a0e91763dca";
    sha256 = "sha256-KZqoSVYBXl0vM6eamW8zb53htf0zs0daXZTS/ME8jEA=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    knlmeanscl
    bm3d
    tcanny
    fmtconv
    mvtools-sf
    nnedi3
  ];

  format = "other";

  installPhase = ''
    install -D Vine.py $out/${python.sitePackages}/Vine.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "Vine" ];

  meta = with lib; {
    description = "A collection of a block/pixel matching based de-halo filter and a set of morphological filters.";
    homepage = "https://github.com/IFeelBloated/Vine";
    license = licenses.lgpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
