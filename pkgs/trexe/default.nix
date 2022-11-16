{
  lib,
  buildbox-common,
  cmake,
  pkgconfig,
  stdenv,
  src
}: stdenv.mkDerivation {
    inherit src;

    name = "trexe";

    nativeBuildInputs = [cmake pkgconfig];
    cmakeFlags = [
      "-DBUILD_TESTS=OFF"
    ];
    buildInputs = [buildbox-common];
    meta = with lib; {
      homepage = "https://gitlab.com/BuildGrid/trexe";
      description = "Lightweight cross-platform remote execution client";
      licencse = licenses.apache;
    };
  }
