#!/bin/bash
#SBATCH --job-name=hyper_job
#SBATCH --output=/scratch/jc11431/slurm_logs/slurm_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=64GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-6

module purge
module load anaconda3/2020.07
source ~/.bashrc
conda activate alignment
myquota
nvidia-smi
which python
wandb login
cd $HOME/git/few-shot-pretraining
echo SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID
wandb agent --count 1 junshern/alignment_pretraining/gn97ss7m
