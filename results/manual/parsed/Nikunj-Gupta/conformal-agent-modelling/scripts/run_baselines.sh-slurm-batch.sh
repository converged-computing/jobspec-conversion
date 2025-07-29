#!/bin/bash
#SBATCH --account=def-ebrahimi
#SBATCH --output=out/%x_%A.out
#SBATCH --error=out/%x_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=64G
#SBATCH --time=2-00:00:00
#SBATCH --array=0-20

export OMP_NUM_THREADS='1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)'

source venv/bin/activate
export OMP_NUM_THREADS=1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)
env=${1}
baseline=${2}
runs=${SLURM_ARRAY_TASK_ID}
tensorboard --logdir="./debug_logs/" --host 0.0.0.0 --load_fast false & 
time python baselines/baselines.py \
                    --envname=$env \
                    --baseline=$baseline \
                    --num_good=2 \
                    --num_adversaries=4 \
                    --num_obstacles=1 \
                    --num_food=2 \
                    --num_forests=2 \
                    --log_dir="./debug_logs/simple_world_all_baselines/" \
                    --seed=$runs \
                    --max_episodes=500000 
