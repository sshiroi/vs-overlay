{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-cnr2";
  version = "1";
  namespace = "cnr2";
  
  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1l77vzmaxqkdmmq1sbpmgn05lvaz06q12wg1rbzyasq34kic47ch";
  };

  meta = with lib; {
    description = "Temporal chroma denoiser for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-cnr2";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
