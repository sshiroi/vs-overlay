final: prev:
let
  common = import ./common.nix final prev;
  callPythonPackage = common.callPythonPackage;
  filter_python_plugins = common.filter_python_plugins;
in rec {

    #Irrational-Encoding-Wizardry
    vs-deband       = callPythonPackage ./iew/vs-deband.nix { };
    vs-rgtools      = callPythonPackage ./iew/vs-rgtools.nix { };
    vs-exprtools    = callPythonPackage ./iew/vs-exprtools.nix { };
    vs-kernels      = callPythonPackage ./iew/vs-kernels.nix { };
    vs-parsedvd     = callPythonPackage ./iew/vs-parsedvd.nix { };
    vs-tools        = callPythonPackage ./iew/vs-tools.nix { };
    vsmask          = callPythonPackage ./iew/vsmask.nix { };
    vs-dehalo       = callPythonPackage ./iew/vs-dehalo.nix { };
    vs-denoise      = callPythonPackage ./iew/vs-denoise.nix { };
    vs-aa           = callPythonPackage ./iew/vs-aa.nix {  };
    vs-scale        = callPythonPackage ./iew/vs-scale.nix { };
    vsutil          = callPythonPackage ./iew/vsutil { };
    vs-dfft         = callPythonPackage ./iew/vs-dfft.nix { };
    vs-deinterlace  = callPythonPackage ./iew/vs-deinterlace.nix { };

    #type other
    fvsfunc         = callPythonPackage ./funcs/fvsfunc.nix { };
    havsfunc        = callPythonPackage ./funcs/havsfunc.nix { };
    kagefunc        = callPythonPackage ./funcs/kagefunc { };
    muvsfunc        = callPythonPackage ./funcs/muvsfunc.nix { };
    xaa             = callPythonPackage ./funcs/xaa.nix { };
    Vine            = callPythonPackage ./funcs/Vine.nix { };
    Plum            = callPythonPackage ./funcs/Plum.nix { };
    atomchtools     = callPythonPackage ./funcs/atomchtools.nix { };
    cooldegrain     = callPythonPackage ./funcs/cooldegrain.nix { };
    wss             = callPythonPackage ./funcs/wss.nix { };
    maskdetail      = callPythonPackage ./funcs/maskdetail.nix { };
    Oyster          = callPythonPackage ./funcs/Oyster.nix { };
    dfmderainbow    = callPythonPackage ./funcs/dfmderainbow.nix { };
    astdr           = callPythonPackage ./funcs/astdr.nix { };
    hysteria        = callPythonPackage ./funcs/hysteria.nix { };
    adjust          = callPythonPackage ./funcs/adjust.nix { };
    edi_rpow2       = callPythonPackage ./funcs/edi_rpow2 { };
    mt_lutspa       = callPythonPackage ./funcs/mt_lutspa { };
    nnedi3_resample = callPythonPackage ./funcs/nnedi3_resample.nix { };
    nnedi3_rpow2    = callPythonPackage ./funcs/nnedi3_rpow2.nix { };
    vsTAAmbk        = callPythonPackage ./funcs/vsTAAmbk {  };

    #packages
    rekt = callPythonPackage ./pypackages/rekt.nix { };
    acsuite = callPythonPackage ./plugins/acsuite { };
    vsgan = callPythonPackage ./plugins/vsgan { };


    #TODO: type normal
    awsmfunc = callPythonPackage ./plugins/awsmfunc { };
    mvsfunc = callPythonPackage ./plugins/mvsfunc { };
    lvsfunc = callPythonPackage ./plugins/lvsfunc { };
    vardefunc = callPythonPackage ./plugins/vardefunc { };
    zzfunc = callPythonPackage ./plugins/zzfunc { };
}