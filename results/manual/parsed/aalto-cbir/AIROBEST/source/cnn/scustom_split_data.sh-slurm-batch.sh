#!/bin/bash
#SBATCH --job-name=create_full_dataset
#SBATCH --account=project_2001284
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=150000
#SBATCH --time=12:00:00

id -a
module purge
module load pytorch
module list
python -u custom_split_data.py
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
