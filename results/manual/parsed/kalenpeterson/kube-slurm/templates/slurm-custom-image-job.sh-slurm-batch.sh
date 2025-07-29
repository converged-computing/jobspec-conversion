#!/bin/bash
#SBATCH --job-name=slurm-single-job
#SBATCH --output=/nas/volumes/homes/dgx/slurm-single-job.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --mem=100

export KUBE_IMAGE='tensorflow:custom'
export KUBE_SCRIPT='/home/dgx/kube-slurm/containers/slurm-single-tf-job/test.sh'

export KUBE_IMAGE=tensorflow:custom
export KUBE_SCRIPT=/home/dgx/kube-slurm/containers/slurm-single-tf-job/test.sh
srun ../wrappers/kube-slurm-custom-image-job.sh
