{ lib
, stdenv
, buildPythonPackage
, cmake
, fetchFromGitHub
, gtest
, nbval
, numpy
, parameterized
, protobuf
, pybind11
, pytestCheckHook
, pythonOlder
, tabulate
, pkg-config
, typing-extensions
, abseil-cpp
}:

let
  gtestStatic = gtest.override { static = true; };
in
stdenv.mkDerivation rec {
  pname = "onnx";
  version = "1.14.1";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-ZVSdk6LeAiZpQrrzLxphMbc1b3rNUMpcxcXPP8s/5tE=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    pybind11
  ];

  buildInputs = [
    abseil-cpp
    protobuf
    numpy
    typing-extensions
  ];

  postPatch = ''
    chmod +x tools/protoc-gen-mypy.sh.in
    patchShebangs tools/protoc-gen-mypy.sh.in

    substituteInPlace setup.py \
      --replace 'setup_requires.append("pytest-runner")' ""

    # prevent from fetching & building own gtest
    substituteInPlace CMakeLists.txt \
      --replace 'include(googletest)' ""
    substituteInPlace cmake/unittest.cmake \
      --replace 'googletest)' ')'
  
    # remove this override in 1.15 that will enable to set the CMAKE_CXX_STANDARD with cmakeFlags
    substituteInPlace CMakeLists.txt \
      --replace 'CMAKE_CXX_STANDARD 11' 'CMAKE_CXX_STANDARD 17'
  '';

  cmakeFlags = [
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DONNX_USE_PROTOBUF_SHARED_LIBS=ON"
    "-Dgoogletest_STATIC_LIBRARIES=${gtestStatic}/lib/libgtest.a"
    "-Dgoogletest_INCLUDE_DIRS=${lib.getDev gtestStatic}/include"
  ];

  preConfigure = ''
    ## Set CMAKE_INSTALL_LIBDIR to lib explicitly, because otherwise it gets set
    ## to lib64 and cmake incorrectly looks for the protobuf library in lib64
    #export CMAKE_ARGS="-DCMAKE_INSTALL_LIBDIR=lib -DONNX_USE_PROTOBUF_SHARED_LIBS=ON"
    #export CMAKE_ARGS+=" -Dgoogletest_STATIC_LIBRARIES=${gtestStatic}/lib/libgtest.a -Dgoogletest_INCLUDE_DIRS=${lib.getDev gtestStatic}/include"
    export ONNX_BUILD_TESTS=1
  '';

  meta = with lib; {
    description = "Open Neural Network Exchange";
    homepage = "https://onnx.ai";
    license = licenses.asl20;
    maintainers = with maintainers; [ acairncross ];
  };
}
