#!/bin/bash
#SBATCH --job-name=pytorch_mnist
#SBATCH --output=pytorch_mnist%j.out
#SBATCH --error=pytorch_mnist%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --array=4,6,8

export WANDB_MODE='offline'

set -x
cd ${SLURM_SUBMIT_DIR}
export WANDB_MODE="offline"
module purge
module load anaconda-py3/2021.05
conda activate /gpfswork/rech/mdb/urz96ze/miniconda3/envs/Barth
module load pytorch-gpu/py3/1.11.0
python ./mnist_example.py --batch-size ${SLURM_ARRAY_TASK_ID}
