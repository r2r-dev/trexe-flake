{
  lib,
  c-ares,
  cmake,
  fetchFromGitLab,
  glog,
  grpc,
  gtest,
  libuuid,
  openssl,
  pkgconfig,
  protobuf,
  stdenv,
  src,
}: stdenv.mkDerivation rec {
    inherit src;

    name = "buildbox-common";
    
    nativeBuildInputs = [cmake pkgconfig];
    cmakeFlags = [
      "-DBUILD_TESTS=OFF"
    ];
    buildInputs = [
      c-ares
      gtest
    ];
    propagatedBuildInputs = [
      libuuid
      glog
      grpc
      openssl
      protobuf
    ];
    meta = with lib; {
      homepage = "https://gitlab.com/BuildGrid/buildbox/buildbox-common";
      description = ''
        buildbox-common is a library containing code used by multiple parts of BuildBox and recc.
        Its API is unstable and it should not be used by other applications.
      '';
      licencse = licenses.apache;
    };
  }
