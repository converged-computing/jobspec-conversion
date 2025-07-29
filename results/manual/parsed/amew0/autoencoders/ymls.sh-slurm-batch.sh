#!/bin/bash
#SBATCH --job-name=auto-vscode
#SBATCH --account=kunf0007
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-23:59:59
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-20

module purge
module load miniconda/3
echo $SLURM_ARRAY_TASK_ID
yml=$(head -n $SLURM_ARRAY_TASK_ID batch_ymls.txt | tail -n 1) 
python -u eit.py $yml
