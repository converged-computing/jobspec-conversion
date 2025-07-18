#!/bin/bash
#FLUX: --job-name=cowy-peanut-2949
#FLUX: --queue=fpgasyn
#FLUX: --urgency=16

module load intelFPGA_pro/20.3.0
module load bittware_520n_mx/19.4.0_hpc
module load intel
module load devel/CMake/3.15.3-GCCcore-8.3.0
SCRIPT_PATH=${SLURM_SUBMIT_DIR}
BENCHMARK_DIR=${SCRIPT_PATH}/../
SYNTH_DIR=${PFS_SCRATCH}/synth/520nmx/RandomAccess
CONFIG_NAMES=("Bittware_520N_MX_IVDEP" "Bittware_520N_MX")
for r in "${CONFIG_NAMES[@]}"; do
    BUILD_DIR=${SYNTH_DIR}/20.3.0-19.4.0-${r}
    mkdir -p ${BUILD_DIR}
    cd ${BUILD_DIR}
    cmake ${BENCHMARK_DIR} -DCMAKE_BUILD_TYPE=Release -DHPCC_FPGA_CONFIG=${BENCHMARK_DIR}/configs/${r}.cmake
    make random_access_kernels_single_intel RandomAccess_intel
done
