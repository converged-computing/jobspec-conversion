#!/bin/bash
#SBATCH --job-name=ser
#SBATCH --output=./logs/%j.out
#SBATCH --error=./logs/%j.err
#SBATCH --mail-user=fabiocat@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100:1
#SBATCH --mem-per-cpu=240GB
#SBATCH --time=4-00:00:00
#SBATCH --exclude=node[100-106,110]

eval "$(conda shell.bash hook)"
conda activate ser
echo "Running run.py"
python run.py
