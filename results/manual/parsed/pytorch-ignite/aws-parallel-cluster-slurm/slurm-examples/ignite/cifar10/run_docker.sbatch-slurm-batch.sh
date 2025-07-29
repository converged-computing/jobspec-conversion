#!/bin/bash
#SBATCH --job-name=cifar10
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=gpu-compute-ondemand
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=gpu-compute-ondemand-dy-g4dnxlarge-1

set -e
cmd="pip install --upgrade git+https://github.com/pytorch/ignite.git && python cifar10-distributed.py run --backend=nccl"
cname="/shared/enroot_data/pytorchignite+vision+latest.sqsh"
srun -l --container-name=ignite-vision --container-image=$cname --container-workdir=$PWD --no-container-remap-root bash -c "$cmd"
