#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=GPU-shared
#SBATCH: --no-requeue

module load python/3.6.4_gcc5_np1.14.5
module load cuda/9.0
cd $SCRATCH/yolact
python3 train.py --config $1 --batch_size $2 --save_interval 5000 &>logs/$1_log
