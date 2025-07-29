#!/bin/bash
#SBATCH --job-name=passt
#SBATCH --output=slurm-%j-passt.high_low_branch.out
#SBATCH --error=slurm-%j-passt.high_low_branch.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:nvidia_a100_80gb_pcie:2
#SBATCH --time=12:00:00

pwd; hostname;
TIME=$(date -Iseconds)
echo $TIME
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/anaconda3/envs/ba3l/lib DDP=2 CUDA_VISIBLE_DEVICES=0,1 python ex_nsynth.py with models.net.rf_norm_t=high_low_branch trainer.use_tensorboard_logger=True -p --debug
