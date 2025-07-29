#!/bin/bash
#SBATCH --job-name=slurm-single-job
#SBATCH --output=/nas/volumes/homes/dgx/slurm-single-job.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --mem=100

export KUBE_IMAGE='registry.local:31500/job-test:latest'
export KUBE_WORK_VOLUME='/nas/volumes/homes/dgx'

export KUBE_IMAGE=registry.local:31500/job-test:latest
export KUBE_WORK_VOLUME=/nas/volumes/homes/dgx
srun ../wrappers/kube-slurm-image-job.sh
