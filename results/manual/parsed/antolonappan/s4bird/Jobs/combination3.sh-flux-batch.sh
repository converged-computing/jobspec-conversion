#!/bin/bash
#FLUX: --job-name=dinosaur-eagle-1077
#FLUX: -N=64
#FLUX: -n=1000
#FLUX: -t=1800
#FLUX: --priority=16

export ini='combination3.ini'

source /global/homes/l/lonappan/.bashrc
conda activate PC2
cd /global/u2/l/lonappan/workspace/s4bird/s4bird
export ini=combination3.ini
mpirun -np $SLURM_NTASKS python combination.py $ini -comb
