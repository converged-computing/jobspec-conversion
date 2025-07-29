#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=02:00:00
#SBATCH --partition=GPU-small
#SBATCH: --no-requeue

module load python/3.6.4_gcc5_np1.14.5
module load cuda/9.0
cd $SCRATCH/epsnet
python3 eval.py --trained_model=$1 --no_bar $2 > logs/eval/$(basename -- $1).log 2>&1
