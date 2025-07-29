#!/bin/bash
#SBATCH --job-name=nanot5_pre_training_job
#SBATCH --account=nlp
#SBATCH --output=pre_training_runs/slurm_%N_%j_out.txt
#SBATCH --error=pre_training_runs/slurm_%N_%j_err.txt
#SBATCH --mail-user=zachary@campus.technion.ac.il
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=100
#SBATCH --gres=gpu_cluster:6
#SBATCH --partition=nlp

nvidia-smi
cd nanoT5 || exit
python -m nanoT5.main \
    optim.name=adamwscale \
    optim.lr_scheduler=cosine
