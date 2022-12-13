{ lib, fetchFromGitHub,  tesseract, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "vs-ocr";
  version = "unstable-2022-12-12";
  namespace = "ocr";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "b5dd7749a2f0694840d287f0bf4d42ce5323a8cf";
    sha256 = "sha256-N2+S4YRMzjpFdRnCXGgvxU1rUKIjmHe7ylzBrB4CPL8=";
  };

  buildInputs = [ tesseract ];

  meta = with lib; {
    description = "OCR plugin for VapourSynth";
    homepage = "https://github.com/vapoursynth/vs-ocr";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
