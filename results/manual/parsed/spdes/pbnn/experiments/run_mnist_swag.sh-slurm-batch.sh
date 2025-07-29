#!/bin/bash
#SBATCH --account=Berzelius-2023-194
#SBATCH --output=./logs/mnist_swag_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=01:00:00
#SBATCH --constraint=fat
#SBATCH --array=0-9

export XLA_PYTHON_CLIENT_PREALLOCATE='true'

source ~/.bashrc
export XLA_PYTHON_CLIENT_PREALLOCATE=true
cd $WRKDIR/pbnn
source ./venv/bin/activate
cd ./experiments
if [ ! -d "./results/mnist" ]
then
    echo "Folder does not exist. Now mkdir"
    mkdir ./results/mnist
fi
nvidia-smi
python mnist/swag.py --id=$SLURM_ARRAY_TASK_ID --adam --lr=0.002 --nlpd_reduce=100
