#!/bin/bash
#FLUX: --job-name=lovable-butter-3080
#FLUX: -t=120
#FLUX: --urgency=16

srun -n $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/box.xml -p dynamic -bh 100 -bw 100 
