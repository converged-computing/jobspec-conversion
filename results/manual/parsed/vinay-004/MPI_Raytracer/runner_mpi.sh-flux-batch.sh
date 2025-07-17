#!/bin/bash
#FLUX: --job-name=rt_mpi
#FLUX: -n=6
#FLUX: --queue=tier3
#FLUX: --urgency=16

module load openmpi
srun -n $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/box.xml -p static_cycles_vertical -cs 1
