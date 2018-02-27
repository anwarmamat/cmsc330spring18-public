#!/bin/bash -e
# Install OCaml and OPAM inside a Cloud9 IDE workspace.
# Run this script and then close and re-open the terminal

# For the latest ocaml version go to:
# http://caml.inria.fr/download.en.html and copy the Gzipped tarball link
OCAML_URL=http://caml.inria.fr/pub/distrib/ocaml-4.06/ocaml-4.06.0.tar.gz

# Create a scratch directory
D=$(mktemp --tmpdir -d c9-ocaml-XXX)
pushd $D

# Download & extract OCaml
wget $OCAML_URL
tar zxf ocaml-*tar.gz
rm ocaml-*.tar.gz
cd ocaml-*

# Build bytecode ocaml
./configure -no-graph -no-curses -prefix $HOME
make world
make install

# Build & install native-code ocaml
./configure -no-graph -no-curses -prefix $HOME
make world.opt
make install

# Download & install opam
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin

# Opam initialization
opam init
eval `opam config env`
opam install ocamlfind
opam install ounit

# Clean up
popd
rm -rf $D