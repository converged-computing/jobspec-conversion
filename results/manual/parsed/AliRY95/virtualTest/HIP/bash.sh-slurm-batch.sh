#!/bin/bash
#FLUX: --job-name=VirtualFunction
#FLUX: --exclusive
#FLUX: -t=60
#FLUX: --urgency=16

export HIP_PATH='/opt/rocm-5.5.1/hip'

ulimit -s unlimited
ulimit -S -s unlimited  # stack
ulimit -S -d unlimited  # data area
ulimit -S -c unlimited
ulimit -S -m unlimited  # memory
ulimit -S -n unlimited  # memory
ulimit -S -q unlimited  # memory
ulimit -l unlimited
module purge
module load PrgEnv-amd
module load CPE-23.02-rocmcc-5.3.0-GPU-softs
module list
rocminfo
module list
export HIP_PATH=/opt/rocm-5.5.1/hip
cd ${SLURM_SUBMIT_DIR}
make clean
make
run -n 1 -- ./HIP_virtualTest
