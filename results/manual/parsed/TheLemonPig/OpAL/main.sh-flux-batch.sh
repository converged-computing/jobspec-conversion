#!/bin/bash
#FLUX: --job-name=gassy-cupcake-5205
#FLUX: -t=7200
#FLUX: --urgency=16

echo Master process running on `hostname`
echo Directory is `pwd`
echo Starting execution at `date`
echo Current PATH is $PATH
module load graphviz/2.40.1
module load python/3.9.0
module load git/2.29.2
source ~/OpAL/venv/bin/activate
cd /users/jhewson/OpAL/
python main_slurm.py --slurm_id $SLURM_ARRAY_TASK_ID
