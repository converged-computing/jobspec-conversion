#!/bin/bash
#FLUX: --job-name=adorable-kerfuffle-1577
#FLUX: -c=4
#FLUX: -t=300
#FLUX: --urgency=16

set -eu 
NAME=sentencepiece
GITSRC=https://github.com/google/sentencepiece
VERSION=v0.1.95
GCC_VERSION=9.3.0
TOOLCHAIN_NAME=gcc-${GCC_VERSION}
module load gcc/${GCC_VERSION}
module load cmake
OPTDIR=/scratch/elec/puhe/Modules/opt/${NAME}-${VERSION}-${TOOLCHAIN_NAME}
BUILDDIR=${OPTDIR}/GIT
INSTALLDIR=${OPTDIR}/installed
MODULEDIR=/scratch/elec/puhe/Modules/modulefiles/${NAME}
mkdir -p $MODULEDIR
MODULEFILE=${MODULEDIR}/${VERSION}-${TOOLCHAIN_NAME}
if [ -d ${MODULEFILE} ]; then
  echo "$MODULEFILE already exists - exiting early"
  exit 1
fi
if [ -d ${INSTALLDIR} ]; then
  echo "Unfinished install, removing $INSTALLDIR and starting again"
  rm -rf ${INSTALLDIR}
fi
if [ -d ${BUILDDIR} ]; then
  echo "Unfinished install, removing $BUILDDIR and starting again"
  rm -rf ${BUILDDIR}
fi
mkdir -p ${OPTDIR}
git clone ${GITSRC} ${BUILDDIR}
cd ${BUILDDIR}
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR} -DCMAKE_INSTALL_RPATH=${INSTALLDIR}/lib64 .. 
make -j4
make install
rm -rf ${BUILDDIR}
cat > ${MODULEFILE} << EOF
proc ModulesHelp { } {
        puts stderr "\tSentencePiece Binaries, version ${VERSION}"
}
module-whatis   "Unsupervised text tokenizer for Neural Network-based text generation."
prepend-path PATH ${INSTALLDIR}/bin
prepend-path LD_LIBRARY_PATH ${INSTALLDIR}/lib64
prepend-path CPLUS_INCLUDE_PATH ${INSTALLDIR}/include
EOF
