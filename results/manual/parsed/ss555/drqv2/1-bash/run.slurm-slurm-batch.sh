#!/bin/bash
#FLUX: --job-name=TravailGPU
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.11.0 # charger les modules
srun python -u optuna/optuna_study_ppo_vae_full_fish_ammorti.py #upright # executer son script
