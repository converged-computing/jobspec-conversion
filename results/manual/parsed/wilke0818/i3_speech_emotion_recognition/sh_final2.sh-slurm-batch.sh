#!/bin/bash
#SBATCH --job-name=ser
#SBATCH --output=./logs_final/%A_%a.out
#SBATCH --error=./logs_final/%A_%a.err
#SBATCH --mail-user=fabiocat@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=240GB
#SBATCH --time=6-06:00:00
#SBATCH --partition=gablab
#SBATCH --array=7-11
#SBATCH --exclude=node[100-106,110]

eval "$(conda shell.bash hook)"
conda activate ser
let "min_seed = ($SLURM_ARRAY_TASK_ID - 1) * 10"
let "max_seed = ($SLURM_ARRAY_TASK_ID) * 10"
echo "Running run.py with min_seed = $min_seed and max_seed = $max_seed"
python run.py --experiment_file experiments_final/run.json --low_seed "$min_seed" --high_seed "$max_seed"
