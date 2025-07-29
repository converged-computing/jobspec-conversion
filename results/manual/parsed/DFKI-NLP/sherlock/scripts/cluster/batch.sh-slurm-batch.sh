#!/bin/bash
#SBATCH --job-name=test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=24G
#SBATCH --array=1-20%4

username="$USER"
IMAGE=/netscratch/enroot/nvcr.io_nvidia_pytorch_21.10-py3.sqsh
WORKDIR="`pwd`"
srun 2>&1 -K --container-mounts=/netscratch/$USER:/netscratch/$USER,/netscratch/$USER/.cache_slurm:/root/.cache,/ds:/ds:ro,"`pwd`":"`pwd`" \
--container-image=$IMAGE \
--container-workdir=$WORKDIR \
--ntasks=1 \
--nodes=1 \
--cpus-per-task=1 \
$*
