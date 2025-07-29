#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=10GB
#SBATCH --time=03:00:00

module purge
module load gcc/8.3.0
module load python/3.7.6
module load nvidia-hpc-sdk/21.7
source env/bin/activate
python -m signjoey train configs/sign.yaml
deactivate
