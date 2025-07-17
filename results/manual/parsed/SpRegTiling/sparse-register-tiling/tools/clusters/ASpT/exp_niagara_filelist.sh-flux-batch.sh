#!/bin/bash
#FLUX: --job-name=$EXPERIMENT_NAME
#FLUX: -c=40
#FLUX: --urgency=16

export MKLROOT='/scinet/intel/oneapi/2021u4/mkl/2021.4.0/'
export MKL_ENABLE_INSTRUCTIONS='AVX512'
export OMP_PROC_BIND='true'

EXPERIMENT_NAME=$(basename -s .yaml $1)
SCRIPT_PATH=$(realpath $0)
SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
BUILD_PATH=$SCRIPT_DIR/../../../build
SOURCE_PATH=$SCRIPT_DIR/../../..
DATASET_DIR_PATH=$SCRIPT_DIR/../../../..
SPMM_BIN_PATH=$BUILD_PATH/cpp_testbed/demo/SPMM_demo
module load NiaEnv/2019b
module load cmake/3.17.3
module load gcc
module load metis/5.1.0
module load papi
cmake -S $SOURCE_PATH -B $BUILD_PATH -DCMAKE_BUILD_TYPE=Release -DENABLE_AVX512=True ..
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
append=''
while read p; do
echo "$SPMM_BIN_PATH -e $1 -d $DATASET_DIR_PATH -m $p -o results/${3}_AVX512_${EXPERIMENT_NAME}_32.csv $append $4"
$SPMM_BIN_PATH -e $1 -d $DATASET_DIR_PATH -m $p -o results/${3}_AVX512_${EXPERIMENT_NAME}_32.csv $append $4
append='-a'
done < $SCRIPT_DIR/../../filelists/$3.txt
exit 0
fi
sbatch <<EOT
module load NiaEnv/2019b
module load cmake/3.17.3
module load gcc
module load metis/5.1.0
module load papi
append=''
while read p; do
echo "$SPMM_BIN_PATH -e $1 -d $DATASET_DIR_PATH -m \$p -o results/${3}_AVX512_${EXPERIMENT_NAME}_32.csv \$append $4"
$SPMM_BIN_PATH -e $1 -d $DATASET_DIR_PATH -m \$p -o results/${3}_AVX512_${EXPERIMENT_NAME}_32.csv \$append $4
append='-a'
done < $SOURCE_PATH/tools/filelists/$3.txt
EOT
