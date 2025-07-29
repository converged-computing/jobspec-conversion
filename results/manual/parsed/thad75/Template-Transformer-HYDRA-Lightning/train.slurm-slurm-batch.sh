#!/bin/bash
#SBATCH --job-name=SAMDETR
#SBATCH --account=way@v100
#SBATCH --output=SAMDETRwCropDynamicTrain%j.out
#SBATCH --error=SAMDETRwCropDynamicTrain%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:8
#SBATCH --time=15:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=8

module purge                      # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.9.0 # charger les modules
set -x                            # activer l'echo des commandes
srun python -u my_app.py # executer son sc
