#!/bin/bash
#FLUX: --job-name=FilteringPol1
#FLUX: -N=100
#FLUX: -n=1000
#FLUX: -t=14400
#FLUX: --urgency=16

export ini='cmbs4_3.ini'

source /global/homes/l/lonappan/.bashrc
conda activate PC2
cd /global/u2/l/lonappan/workspace/s4bird/s4bird
export ini=cmbs4_3.ini
mpirun -np $SLURM_NTASKS python quest.py $ini -ivt
