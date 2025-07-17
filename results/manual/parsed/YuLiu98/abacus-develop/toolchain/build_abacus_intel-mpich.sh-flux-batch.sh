#!/bin/bash
#FLUX: --job-name=build
#FLUX: -n=16
#FLUX: --urgency=16

export PATH='${PREFIX}/bin":${PATH}'

TOOL=$(pwd)
ABACUS_DIR=..
INSTALL_DIR=$TOOL/install
source $INSTALL_DIR/setup
cd $ABACUS_DIR
ABACUS_DIR=$(pwd)
BUILD_DIR=build_abacus_intel-mpich
rm -rf $BUILD_DIR
PREFIX=$ABACUS_DIR
ELPA=$INSTALL_DIR/elpa-2023.05.001/cpu
CEREAL=$INSTALL_DIR/cereal-1.3.2/include/cereal
LIBXC=$INSTALL_DIR/libxc-6.2.2
cmake -B $BUILD_DIR -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_CXX_COMPILER=icpx \
        -DMPI_CXX_COMPILER=mpicxx \
        -DMKLROOT=$MKLROOT \
        -DELPA_DIR=$ELPA \
        -DCEREAL_INCLUDE_DIR=$CEREAL \
        -DLibxc_DIR=$LIBXC \
        -DENABLE_LCAO=ON \
        -DENABLE_LIBXC=ON \
        -DUSE_OPENMP=ON \
        -DUSE_ELPA=ON \
        # -DENABLE_DEEPKS=1 \
        # -DTorch_DIR=$LIBTORCH \
        # -Dlibnpy_INCLUDE_DIR=$LIBNPY \
        # -DENABLE_LIBRI=ON \
        # -DLIBRI_DIR=$LIBRI \
        # -DLIBCOMM_DIR=$LIBCOMM \
	    # -DDeePMD_DIR=$DEEPMD \
	    # -DTensorFlow_DIR=$DEEPMD \
cmake --build $BUILD_DIR -j `nproc` 
cmake --install $BUILD_DIR 2>/dev/null
cat << EOF > "${TOOL}/abacus_env.sh"
source $INSTALL_DIR/setup
export PATH="${PREFIX}/bin":${PATH}
EOF
