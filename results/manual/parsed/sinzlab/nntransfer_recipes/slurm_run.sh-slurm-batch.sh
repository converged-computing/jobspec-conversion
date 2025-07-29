#!/bin/bash
#SBATCH --job-name=singularity_test
#SBATCH --output=work/logs/hostname_%j.out
#SBATCH --error=work/logs/hostname_%j.err
#SBATCH --mail-user=arnenix@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1000
#SBATCH --time=00:01:00

./singularity_run.sh run 0 python3 bias_transfer_recipes/main.py --recipe $1 --experiment $2
