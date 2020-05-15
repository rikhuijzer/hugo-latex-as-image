#!/bin/sh
# The aim of this script is to override `pandoc` so we can pass extra flags.

set -e

PANDOC_ORIGINAL=$(which pandoc)
export PANDOC_ORIGINAL

ghc --make bin/mylatex-formulae-filter.hs

# Overrides pandoc.
PATH=$PWD/bin:$PATH

hugo "$@"
