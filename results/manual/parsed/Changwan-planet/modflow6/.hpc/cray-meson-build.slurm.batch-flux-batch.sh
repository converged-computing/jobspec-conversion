#!/bin/bash
#FLUX: --job-name=denali-build
#FLUX: -n=2
#FLUX: -t=600
#FLUX: --priority=16

export PKG_CONFIG_PATH='/opt/cray/pe/mpt/7.7.19/gni/mpich-intel/16.0/lib/pkgconfig:/opt/cray/pe/petsc/3.14.5.0/real/INTEL/19.1/x86_skylake/lib/pkgconfig:$PKG_CONFIG_PATH'

set -euxo pipefail
module switch PrgEnv-${PE_ENV,,} PrgEnv-intel
module load cray-petsc meson ninja
export PKG_CONFIG_PATH=/opt/cray/pe/mpt/7.7.19/gni/mpich-intel/16.0/lib/pkgconfig:/opt/cray/pe/petsc/3.14.5.0/real/INTEL/19.1/x86_skylake/lib/pkgconfig:$PKG_CONFIG_PATH
module list
MODFLOW6ROOT=$(pwd)
VERSION=$(cat "$MODFLOW6ROOT/version.txt") 
echo "MODFLOW 6 version: $VERSION"
BUILDDIR=$MODFLOW6ROOT/$PE_ENV-$VERSION
BINDIR=$BUILDDIR/src
TESTDIR=$MODFLOW6ROOT/.mf6minsim
PREFIX=/home/software/denali/contrib/impd/apps/modflow/$VERSION/$PE_ENV/19.1.0.166
CC=cc CXX=CC F77=ftn F90=ftn FC=ftn meson setup $BUILDDIR --prefix=$PREFIX --bindir=bin --libdir=lib -Dcray=true -Ddebug=false
meson compile -C $BUILDDIR
meson install -C $BUILDDIR
cd $TESTDIR
$BINDIR/mf6
srun $BINDIR/mf6 -p
