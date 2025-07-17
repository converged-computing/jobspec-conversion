#!/bin/bash
#FLUX: --job-name=pytorch_mnist
#FLUX: -n=4
#FLUX: -c=10
#FLUX: -t=10800
#FLUX: --urgency=16

export WANDB_MODE='offline'

set -x
cd ${SLURM_SUBMIT_DIR}
export WANDB_MODE="offline"
module purge
module load anaconda-py3/2021.05
conda activate /gpfswork/rech/mdb/urz96ze/miniconda3/envs/Barth
module load pytorch-gpu/py3/1.11.0
python ./mnist_example.py --batch-size ${SLURM_ARRAY_TASK_ID}
