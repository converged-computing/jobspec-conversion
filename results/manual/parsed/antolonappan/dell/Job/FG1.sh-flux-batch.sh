#!/bin/bash
#FLUX: --job-name=FG1_LBIRD
#FLUX: -N=32
#FLUX: -n=500
#FLUX: -t=1800
#FLUX: --urgency=16

export ini='LB_FG1.ini'

source /global/homes/l/lonappan/.bashrc
cd /global/u2/l/lonappan/workspace/dell
export ini=LB_FG1.ini
mpirun -np $SLURM_NTASKS python simulation.py $ini -fg
