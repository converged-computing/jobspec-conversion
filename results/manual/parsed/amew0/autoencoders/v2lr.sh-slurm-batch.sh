#!/bin/bash
#SBATCH --job-name=v2lr-auto-vscode
#SBATCH --account=kunf0007
#SBATCH --output=./output/v2lr/v2lr-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

path="./output/v2lr/v2lr-"
j=$SLURM_JOB_ID
original_filename="${path}${j}.out"
new_filename="${path}${1}.out"
mv "$original_filename" "$new_filename"
module purge
module load miniconda/3
conda activate eit
echo $j
echo $1
echo $2
python -u v2lr.py $1
