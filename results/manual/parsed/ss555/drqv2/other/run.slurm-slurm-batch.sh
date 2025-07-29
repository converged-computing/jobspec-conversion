#!/bin/bash
#SBATCH --job-name=TravailGPU
#SBATCH --account=yqs@v100
#SBATCH --output=TravailGPU%j.out
#SBATCH --error=TravailGPU%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=v100-32g

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.10.1 # charger les modules
srun python -u train_gym.py #OVERRIDE IN CONFIG
