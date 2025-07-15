#!/bin/bash
#FLUX: --job-name=KFInSAR
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

source ~/.bashrc
export OMP_NUM_THREADS=8
mpirun -n 30 python -u kfts.py -c configs/refconfigfile.ini
echo Time is `date`
