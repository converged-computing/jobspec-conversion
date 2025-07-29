#!/bin/bash
#SBATCH --job-name=sweep-job
#SBATCH --account=norom1
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --time=20:00:00
#SBATCH --partition=palamut-cuda
#SBATCH --exclude=palamut9

SWEEP_ID=ayberkydn/vis/gd03qcz6
CUDA_VISIBLE_DEVICES=0 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
CUDA_VISIBLE_DEVICES=0 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
CUDA_VISIBLE_DEVICES=1 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
CUDA_VISIBLE_DEVICES=1 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
wait
