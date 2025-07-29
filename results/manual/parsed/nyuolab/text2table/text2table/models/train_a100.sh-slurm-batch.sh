#!/bin/bash
#FLUX: --job-name=text2table
#FLUX: -N=3
#FLUX: -c=96
#FLUX: --queue=oermannlab
#FLUX: -t=432000
#FLUX: --urgency=16

echo "hostname:"
hostname
source ~/.bashrc
echo "setup env"
pwd
nvidia-smi
module load cuda/11.4 gcc/9.3.0 nccl
conda activate text2table
which deepspeed
deepspeed --hostfile /gpfs/data/oermannlab/users/yangz09/summer/text2table/text2table/hostfile --num_gpus=8 --num_nodes=3 train_model.py
