#!/bin/bash
#FLUX: --job-name=butterscotch-malarkey-7058
#FLUX: -t=120
#FLUX: --priority=16

srun -n $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/box.xml -p dynamic -bh 100 -bw 100 
