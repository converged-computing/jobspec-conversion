#!/bin/bash
#SBATCH --job-name=RM
#SBATCH --account=scw2050
#SBATCH --output=o.%x.%j
#SBATCH --error=e.%x.%j
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=06:00:00
#SBATCH --partition=gpu_v100

export PYTHONPATH='${PYTHONPATH}:/home/c.scmse/Funtuner'

git pull origin dev-train 
module purge
module load deepspeed
module list
export PYTHONPATH="${PYTHONPATH}:/home/c.scmse/Funtuner"
exec singularity exec --nv $DEEPSPEED_IMAGE /nfshome/store03/users/c.scmse/venv/bin/python3 funtuner/trainer.py
