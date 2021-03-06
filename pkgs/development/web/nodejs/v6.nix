{ stdenv, fetchurl, openssl, python2, zlib, libuv, v8, utillinux, http-parser
, pkgconfig, runCommand, which, libtool, fetchpatch
, callPackage
, darwin ? null
, enableNpm ? true
}@args:

let
  nodejs = import ./nodejs.nix args;
  baseName = if enableNpm then "nodejs" else "nodejs-slim";
in
  stdenv.mkDerivation (nodejs // rec {
    version = "6.8.0";
    name = "${baseName}-${version}";
    src = fetchurl {
      url = "https://nodejs.org/download/release/v${version}/node-v${version}.tar.xz";
      sha256 = "13arzwki13688hr1lh871y06lrk019g4hkasmg11arm8j1dcwcpq";
    };

    patches = nodejs.patches ++ [
      (fetchpatch {
        url = "https://github.com/nodejs/node/commit/fc164acbbb700fd50ab9c04b47fc1b2687e9c0f4.patch";
        sha256 = "1rms3n09622xmddn013yvf5c6p3s8w8s0d2h813zs8c1l15k4k1i";
      })
    ];

  })

