#!/bin/bash
#FLUX: --job-name=carnivorous-salad-3171
#FLUX: --urgency=16

export FI_MR_CACHE_MONITOR='memhooks  # alternative cache monitor'
export ROCFFT_RTC_CACHE_PATH='/dev/null'
export OMP_NUM_THREADS='1'
export WARPX_NMPI_PER_NODE='8'
export TOTAL_NMPI='$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))'

export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor
export ROCFFT_RTC_CACHE_PATH=/dev/null
export OMP_NUM_THREADS=1
export WARPX_NMPI_PER_NODE=8
export TOTAL_NMPI=$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))
EXE=/lustre/orion/phy122/world-shared/pnorbert/warpx/warpx
WARPX_ROOT=/ccs/proj/e2e/pnorbert/warpx
INPUT=/lustre/orion/phy122/world-shared/pnorbert/warpx/input.n${SLURM_JOB_NUM_NODES}
source $WARPX_ROOT/frontier_warpx_profile.sh
function run_case () {
    MODE=${1:-bp5}
    RUN=${2:-1}
    CONF=$WARPX_ROOT/job.frontier/parameters-${MODE}.txt
    LOG=log-${MODE}.${RUN}
    echo "========== MODE $MODE  RUN $RUN ========="
    mkdir ${MODE}.${RUN}
    pushd ${MODE}.${RUN}
    cat $INPUT $CONF >> input
    if [ ! -f "$INPUT" ]; then
        echo "WARNING: warpx input file $INPUT does not exist"
    fi
    if [ ! -f "$CONF" ]; then
        echo "WARNING: adios settings file $CONF does not exist"
    fi
    date
    echo `srun -N${SLURM_JOB_NUM_NODES} -n${TOTAL_NMPI} --ntasks-per-node=${WARPX_NMPI_PER_NODE} ${EXE} input > output.txt`
    srun -N${SLURM_JOB_NUM_NODES} -n${TOTAL_NMPI} --ntasks-per-node=${WARPX_NMPI_PER_NODE} ${EXE} input > output.txt
    date
    sleep 30
    popd
}
run_case nullcore 1
run_case ews 1
run_case ew 1
run_case shm 1
run_case ew-ar1 1
