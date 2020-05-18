{ pkgs ? import <nixpkgs> {} }:

let
  # 20.03
  rev = "5272327b81ed355bbed5659b8d303cf2979b6953";
  channel = fetchTarball "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
  config = {
    allowBroken = true;
  };
  pkgs = import channel { inherit config; };
  myHaskellPackages = with pkgs.haskellPackages; [
    pandoc-citeproc
    pandoc-types
    latex-formulae-pandoc
  ];
  haskellEnv = pkgs.haskellPackages.ghcWithPackages (self:
    myHaskellPackages
  );
  myTex = with pkgs; texlive.combine {
    inherit (texlive) scheme-basic amsfonts mathtools stmaryrd;
  };
# Do not change to nix-build Dockerfile, it will have similar (huge, that is, >1GB) size.
in pkgs.mkShell {
  name = "env";
  buildInputs = with pkgs; [
    ghostscript
    git 
    haskellEnv
    hugo
    imagemagick
    pandoc
    # texlive.combined.scheme-basic
    myTex
    which
  ];
}
