#!/bin/bash
#SBATCH --job-name=diff-auto-vscode
#SBATCH --account=kunf0007
#SBATCH --output=./output/img/bt-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:59:59
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

path="./output/img/bt-"
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
python -u bt.py
