#!/bin/bash
#FLUX: --job-name=pretraining
#FLUX: -N=3
#FLUX: -c=40
#FLUX: --queue=oermannlab
#FLUX: -t=2592000
#FLUX: --urgency=16

export HOME='/gpfs/home/jiangy09/'

echo "hostname:"
hostname
source /gpfs/data/oermannlab/users/lavender/.bashrc
export HOME=/gpfs/home/jiangy09/
echo "home dir is"
echo $HOME
nvidia-smi
module load cuda/11.4 gcc/10.2.0 nccl
conda activate /gpfs/data/oermannlab/users/lavender/.conda/envs/ds_hf #ds_hf
which deepspeed
run_str='deepspeed --hostfile configs/hostfile --num_gpus=8 --num_nodes=3 pretrain_multinode_hydra.py --deepspeed configs/pretrain_configs/deepspeed_config_multinode.json'
echo "$run_str"
$run_str
