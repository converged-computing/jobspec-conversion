#!/bin/bash
#FLUX: --job-name=vasp-test-rome
#FLUX: --queue=ccq
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'

export OMP_NUM_THREADS=4
ulimit -s unlimited
module purge
module load vasp/6.3.0_nixpack_gnu slurm
mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std
