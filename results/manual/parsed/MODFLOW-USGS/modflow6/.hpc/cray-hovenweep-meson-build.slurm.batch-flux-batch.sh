#!/bin/bash
#FLUX: --job-name=hovenweep-build
#FLUX: -n=2
#FLUX: -t=600
#FLUX: --priority=16

export PKG_CONFIG_PATH='$CRAY_MPICH_DIR/lib/pkgconfig:$PKG_CONFIG_PATH'

set -euxo pipefail
module switch PrgEnv-${PE_ENV,,} PrgEnv-intel
module load petsc/3.15.5 meson/1.2.1 ninja/1.11.1
export PKG_CONFIG_PATH=$CRAY_MPICH_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
module list
MODFLOW6ROOT=$(pwd)
VERSION=$(cat "$MODFLOW6ROOT/version.txt") 
echo "MODFLOW 6 version: $VERSION"
BUILDDIR=$MODFLOW6ROOT/$PE_ENV-$VERSION
BINDIR=$BUILDDIR/src
TESTDIR=$MODFLOW6ROOT/.mf6minsim
PREFIX=/home/software/hovenweep/contrib/impd/apps/modflow/$VERSION/$PE_ENV/2023.2.0
CC=cc CXX=CC F77=ftn F90=ftn FC=ftn meson setup $BUILDDIR --prefix=$PREFIX --bindir=bin --libdir=lib -Dcray=true -Ddebug=false --wipe
meson compile -C $BUILDDIR
meson install -C $BUILDDIR
cd $TESTDIR
$BINDIR/mf6
srun $BINDIR/mf6 -p
