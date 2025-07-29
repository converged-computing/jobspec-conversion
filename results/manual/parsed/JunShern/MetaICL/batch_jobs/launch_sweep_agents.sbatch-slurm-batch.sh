#!/bin/bash
#SBATCH --job-name=sweep_job
#SBATCH --output=/scratch/jc11431/slurm_logs/slurm_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=32GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-9

USERDIR=/home/jc11431
module purge
module load anaconda3/2020.07
source ~/.bashrc
conda activate $USERDIR/.conda/envs/metaicl-a100
myquota
nvidia-smi
which python
wandb login
sweep_path=$1
cd $USERDIR/git/MetaICL
echo SLURM_JOBID $SLURM_JOBID
echo SLURM_ARRAY_JOB_ID $SLURM_ARRAY_JOB_ID
echo SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID
wandb agent --count 1 $sweep_path
