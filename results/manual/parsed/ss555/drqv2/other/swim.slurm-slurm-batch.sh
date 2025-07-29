#!/bin/bash
#FLUX: --job-name=TravailGPU
#FLUX: -c=10
#FLUX: -t=36000
#FLUX: --urgency=16

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.10.1 # charger les modules
srun python -u train_dm_custom.py #upright # executer son script
