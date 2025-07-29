#!/bin/bash
#SBATCH --job-name=TravailGPU
#SBATCH --account=yqs@v100
#SBATCH --output=TravailGPU%j.out
#SBATCH --error=TravailGPU%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=v100-16g

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.10.1 # charger les modules
conda activate
srun python -u train.py task=fish_upright # executer son script
