#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=batch
#SBATCH --constraint=ntasks-per-node=1

CWD=$PWD
PROJECT_PATH=$1
PYTHON_PATH=$2
CONFIG_FILE=$3
CUDA_DEVICE=$4
cd $PROJECT_PATH/slurm
srun \
    -o logs/%j.out \
    -e logs/%j.err \
    /bin/bash run.sh $PYTHON_PATH $CONFIG_FILE $CUDA_DEVICE
cd $CWD
exit 0
