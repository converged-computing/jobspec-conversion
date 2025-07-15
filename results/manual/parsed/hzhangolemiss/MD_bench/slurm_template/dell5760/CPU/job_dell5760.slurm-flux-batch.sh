#!/bin/bash
#FLUX: --job-name=xxx
#FLUX: -t=2592000
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
mpiexec --bind-to core --map-by core -n 8 lmp_2Aug2023_update3_more_gcc_sfft_openmpi_cuda_mps -i input.lmps
