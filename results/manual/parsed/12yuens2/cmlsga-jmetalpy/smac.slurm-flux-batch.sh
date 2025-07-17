#!/bin/bash
#FLUX: --job-name=dinosaur-rabbit-5212
#FLUX: -n=8
#FLUX: -t=86700
#FLUX: --urgency=16

module load python/3.7.3
source env/bin/activate
cd $HOME/cmlsga-jmetalpy
python src/tuning.py nsgaii ZDT${SLURM_ARRAY_TASK_ID} ga
