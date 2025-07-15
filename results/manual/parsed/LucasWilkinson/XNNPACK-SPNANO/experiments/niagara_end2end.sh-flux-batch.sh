#!/bin/bash
#FLUX: --job-name="$EXPERIMENT_NAME"
#FLUX: -c=40
#FLUX: --priority=16

export MKL_ENABLE_INSTRUCTIONS='AVX512'
export OMP_PROC_BIND='true'

SCRIPT_PATH=$(realpath $0)
SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
BUILD_PATH=$SCRIPT_DIR/../build
SOURCE_PATH=$SCRIPT_DIR/../
END2END_BIN_PATH=$BUILD_PATH/end2end-bench
module load cmake/3.17.3
module load gcc
cmake -S $SOURCE_PATH -B $BUILD_PATH -DCMAKE_BUILD_TYPE=Release
echo CLEAN ${CLEAN}
if [ "${CLEAN}" ]; then
  make -C $BUILD_PATH clean
fi
make -C $BUILD_PATH -j 20 end2end-bench
echo ""
echo "Submitting using:"
echo "   BUILD_PATH=$BUILD_PATH"
echo "   SOURCE_PATH=$SOURCE_PATH"
echo "   END2END_BIN_PATH=END2END_BIN_PATH"
echo ""
echo ${INTERACTIVE}
if [ "${INTERACTIVE}" ]; then
    echo "INTERACTIVE set, skipping submit and running commands here"
    $END2END_BIN_PATH --benchmark_counters_tabular=true --benchmark_out=end2end.json
    exit 0
fi
sbatch <<EOT
export MKL_ENABLE_INSTRUCTIONS=AVX512
export OMP_PROC_BIND=true
$END2END_BIN_PATH -benchmark_counters_tabular=true --benchmark_out=end2end.json
EOT
