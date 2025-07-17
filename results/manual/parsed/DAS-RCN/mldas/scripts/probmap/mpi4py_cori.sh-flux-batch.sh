#!/bin/bash
#FLUX: --job-name=prob-multiproc
#FLUX: -N=3
#FLUX: --queue=regular
#FLUX: -t=18000
#FLUX: --urgency=16

module load pytorch/v1.6.0
srun -n 96 -c 2 python $HOME/mldas/mldas/assess.py probmap -c $HOME/mldas/configs/assess.yaml -o $SCRATCH/probmaps --mpi
