#!/bin/bash
#SBATCH --job-name=oneat
#SBATCH --output=oneat.o%j
#SBATCH --error=oneat.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=v100-32g

module purge # purging modules inherited by default
module load tensorflow-gpu/py3/2.7.0
module load anaconda-py3/2020.11
conda deactivate
conda activate naparienv
set -x # activating echo of
srun python -u TrainProjectionModel.py
