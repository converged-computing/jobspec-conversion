#!/bin/bash
#SBATCH --job-name=TravailGPU
#SBATCH --account=yqs@v100
#SBATCH --output=swim_medium%j.out
#SBATCH --error=TravailGPU%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --qos=qos_gpu-t4
#SBATCH --constraint=v100-16g

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.10.1 # charger les modules
srun python -u train_dm_custom.py #upright # executer son script
