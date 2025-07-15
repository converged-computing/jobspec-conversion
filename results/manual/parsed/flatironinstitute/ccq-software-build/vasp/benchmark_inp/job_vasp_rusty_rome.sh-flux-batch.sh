#!/bin/bash
#FLUX: --job-name=vasp-test-rome
#FLUX: --queue=ccq
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm
module load vasp/6.4.0_nix2_gnu
mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std
