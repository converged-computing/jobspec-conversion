#!/bin/bash
#FLUX: --job-name=$EXPERIMENT_NAME
#FLUX: -c=40
#FLUX: --urgency=16

export OMP_PROC_BIND='true'

EXPERIMENT_NAME=$(basename -s .yaml $1)
SCRIPT_PATH=$(realpath $0)
SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
BUILD_PATH=$SCRIPT_DIR/../../build
SOURCE_PATH=$SCRIPT_DIR/../..
DATASET_DIR_PATH=$SCRIPT_DIR/../../..
SPMM_BIN_PATH=$BUILD_PATH/cpp_testbed/demo/SPMM_demo
echo "** Can't load modules in a script on graham for some reason, please load the following: "
echo ""
echo "module load cmake/3.22.1"
echo "module load gcc"
echo "module load imkl/2022.1.0"
echo "module load metis/5.1.0"
echo "module load papi"
echo ""
cmake -S $SOURCE_PATH -B $BUILD_PATH -DCMAKE_BUILD_TYPE=Release -DENABLE_AVX2=True ..
echo CLEAN ${CLEAN}
if [ "${CLEAN}" ]; then
  make -C $BUILD_PATH clean
fi
make -C $BUILD_PATH -j 20 SPMM_demo
echo ""
echo "Submitting using:"
echo "   EXPERIMENT=$1"
echo "   BUILD_PATH=$BUILD_PATH"
echo "   SOURCE_PATH=$SOURCE_PATH"
echo "   DATASET_DIR_PATH=$DATASET_DIR_PATH"
echo "   SPMM_BIN_PATH=$SPMM_BIN_PATH"
echo ""
echo ${INTERACTIVE}
if [ "${INTERACTIVE}" ]; then
    echo "INTERACTIVE set, skipping submit and running commands here"
    $SPMM_BIN_PATH -e $1 -d $DATASET_DIR_PATH
    exit 0
fi
sbatch <<EOT
module load cmake/3.22.1
module load gcc
module load imkl/2022.1.0
module load metis/5.1.0
module load papi
lscpu
export OMP_PROC_BIND=true
$SPMM_BIN_PATH -e $1 -d $DATASET_DIR_PATH
EOT
