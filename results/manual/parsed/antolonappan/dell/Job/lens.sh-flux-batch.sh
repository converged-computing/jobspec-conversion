#!/bin/bash
#FLUX: --job-name=scruptious-leopard-2304
#FLUX: -N=16
#FLUX: -n=100
#FLUX: -c=2
#FLUX: -t=600
#FLUX: --urgency=16

export ini='LB_FG2.ini'

source /global/homes/l/lonappan/.bashrc
conda activate cmblens
cd /global/u2/l/lonappan/workspace/LBlens
export ini=LB_FG2.ini
mpirun -np $SLURM_NTASKS python simulation.py $ini  -lens
