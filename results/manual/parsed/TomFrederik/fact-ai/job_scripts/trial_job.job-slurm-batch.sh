#!/bin/bash
#SBATCH --job-name=trial_job
#SBATCH --output=outputs/trial_job_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:0
#SBATCH --mem=32000M
#SBATCH --time=04:30:00
#SBATCH --array=1-1%1

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
cd $HOME/fact-ai/
source activate fact-ai-lisa
srun python -u main.py --model baseline --prim_hidden 64 32 --dataset LSAC --disable_warnings --num_workers 6 --no_grid_search --prim_lr 0.1 --batch_size 128 --seed_run --seed 1 --train_steps 1250
srun python -u main.py --model ARL --dataset LSAC --disable_warnings --num_workers 6 --no_grid_search --prim_lr 0.1 --batch_size 128 --seed_run --seed 1 --pretrain_steps 250 --train_steps 1000
