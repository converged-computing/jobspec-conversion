#!/bin/bash
#FLUX: --job-name=faux-buttface-5885
#FLUX: --priority=16

module load openmpi
srun -n $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/box.xml -p static_cycles_vertical -cs 1
