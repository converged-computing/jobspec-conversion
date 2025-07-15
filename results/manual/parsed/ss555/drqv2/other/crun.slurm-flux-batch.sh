#!/bin/bash
#FLUX: --job-name=TravailGPU
#FLUX: -t=600
#FLUX: --urgency=16

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.10.1 # charger les modules
conda activate
srun python -u train.py task=fish_upright # executer son script
