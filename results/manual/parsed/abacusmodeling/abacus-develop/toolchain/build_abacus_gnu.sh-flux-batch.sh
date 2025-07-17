#!/bin/bash
#FLUX: --job-name=build
#FLUX: -n=16
#FLUX: --urgency=16

export PATH='${PREFIX}/bin":\${PATH}'

ABACUS_DIR=..
TOOL=$(pwd)
INSTALL_DIR=$TOOL/install
source $INSTALL_DIR/setup
cd $ABACUS_DIR
ABACUS_DIR=$(pwd)
BUILD_DIR=build_abacus_gnu
rm -rf $BUILD_DIR
PREFIX=$ABACUS_DIR
LAPACK=$INSTALL_DIR/openblas-0.3.25/lib
SCALAPACK=$INSTALL_DIR/scalapack-2.2.1/lib
ELPA=$INSTALL_DIR/elpa-2023.05.001/cpu
FFTW3=$INSTALL_DIR/fftw-3.3.10
CEREAL=$INSTALL_DIR/cereal-1.3.2/include/cereal
LIBXC=$INSTALL_DIR/libxc-6.2.2
cmake -B $BUILD_DIR -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_CXX_COMPILER=g++ \
        -DMPI_CXX_COMPILER=mpicxx \
        -DLAPACK_DIR=$LAPACK \
        -DSCALAPACK_DIR=$SCALAPACK \
        -DELPA_DIR=$ELPA \
        -DFFTW3_DIR=$FFTW3 \
        -DCEREAL_INCLUDE_DIR=$CEREAL \
        -DLibxc_DIR=$LIBXC \
        -DENABLE_LCAO=ON \
        -DENABLE_LIBXC=ON \
        -DUSE_OPENMP=ON \
        -DUSE_ELPA=ON \
cmake --build $BUILD_DIR -j `nproc` 
cmake --install $BUILD_DIR 2>/dev/null
cat << EOF > "${TOOL}/abacus_env.sh"
source $INSTALL_DIR/setup
export PATH="${PREFIX}/bin":\${PATH}
EOF
