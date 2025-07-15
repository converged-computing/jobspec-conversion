#!/bin/bash
#FLUX: --job-name=bricky-blackbean-9838
#FLUX: -N=20
#FLUX: -n=400
#FLUX: -t=300
#FLUX: --urgency=16

export ini='litebird1.ini'

source /global/homes/l/lonappan/.bashrc
conda activate PC2
cd /global/u2/l/lonappan/workspace/s4bird/s4bird
export ini=litebird1.ini
mpirun -np $SLURM_NTASKS python quest.py $ini -qclss
