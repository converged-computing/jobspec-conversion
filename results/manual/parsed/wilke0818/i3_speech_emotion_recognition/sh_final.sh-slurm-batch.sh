#!/bin/bash
#SBATCH --job-name=ser
#SBATCH --output=./logs_final/%A.out
#SBATCH --error=./logs_final/%A.err
#SBATCH --mail-user=wilke18@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=40GB
#SBATCH --time=08:00:00
#SBATCH --exclude=node[100-106,110]

eval "$(conda shell.bash hook)"
conda activate ser
let "min_seed = 14"
let "max_seed = 15"
echo "Running train.py with min_seed = $min_seed and max_seed = $max_seed"
python train.py --experiment_file experiments/run.json --low_seed "$min_seed" --high_seed "$max_seed"
