{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, fetchpatch }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "vapoursynth-adjust";
  version = "1";
  importname = "adjust";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "0wd6sh788ljb4vj6fd5zv2cx7nl6x1k3lnz44n7p3ac5vfskjz8a";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/dubhater/vapoursynth-adjust/commit/a3af7cb57cb37747b0667346375536e65b1fed17.patch";
      sha256 = "sha256-0N7oSsYj0/F0PwswI+1hgM7Gu1KKWdlJOuYf24wlEUw=";
    })
  ];

  vs_pythondeps = [];
  vs_binarydeps = [];

  meta = with lib; {
    description = "A VapourSynth port of the Avisynth filter Tweak";
    homepage = "https://github.com/dubhater/vapoursynth-adjust";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
