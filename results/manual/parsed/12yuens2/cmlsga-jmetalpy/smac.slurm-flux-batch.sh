#!/bin/bash
#FLUX: --job-name=crunchy-buttface-8133
#FLUX: -n=8
#FLUX: -t=86700
#FLUX: --priority=16

module load python/3.7.3
source env/bin/activate
cd $HOME/cmlsga-jmetalpy
python src/tuning.py nsgaii ZDT${SLURM_ARRAY_TASK_ID} ga
