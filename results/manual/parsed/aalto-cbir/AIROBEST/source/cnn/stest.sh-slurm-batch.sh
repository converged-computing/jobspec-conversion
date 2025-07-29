#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=project_2001284
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=150000
#SBATCH --time=01:00:00

id -a
module purge
module load pytorch
module list
python -u test.py
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
