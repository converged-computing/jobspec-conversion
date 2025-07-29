#!/bin/bash
#SBATCH --job-name=slurm-jupyter-job
#SBATCH --output=//nas/volumes/homes/dgx/slurm-jupyter-job.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --mem=100

export KUBE_IMAGE='KUBE_IMAGE=registry.local:31500/slurm-tensorflow:latest'

export KUBE_IMAGE=KUBE_IMAGE=registry.local:31500/slurm-tensorflow:latest
srun ../wrappers/kube-slurm-jupyter-job.sh
