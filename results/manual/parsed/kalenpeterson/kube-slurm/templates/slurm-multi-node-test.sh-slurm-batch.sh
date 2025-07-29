#!/bin/bash
#SBATCH --job-name=multinodeTestJob
#SBATCH --output=log-%j.out
#SBATCH --error=logErrors-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

export KUBE_IMAGE='docker.io/kalenpeterson/lambda-openmpi:20230720-v19'
export KUBE_SCRIPT='/nas/slurm/data/run-sleep.sh'
export KUBE_DATA_VOLUME='/nas/slurm/data'
export KUBECONFIG='~/.kube/config'

export KUBE_IMAGE=docker.io/kalenpeterson/lambda-openmpi:20230720-v19
export KUBE_SCRIPT=/nas/slurm/data/run-sleep.sh
export KUBE_DATA_VOLUME=/nas/slurm/data
export KUBECONFIG=~/.kube/config
srun /home/dgx/kube-slurm/wrappers/kube-slurm-multinode-job-v2.sh
