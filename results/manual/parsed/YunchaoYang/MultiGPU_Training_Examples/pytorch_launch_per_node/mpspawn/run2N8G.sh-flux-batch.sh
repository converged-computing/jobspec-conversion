#!/bin/bash
#FLUX: --job-name=peachy-itch-2081
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=hpg-ai
#FLUX: -t=28800
#FLUX: --priority=16

export MASTER_ADDR='$(hostname)'

module load conda
conda activate torch-timm
ip1=`hostname -I | awk '{print $2}'`
echo $ip1
export MASTER_ADDR=$(hostname)
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
srun python train.py --nodes=2 --ngpus 8 --ip_adress $ip1 --epochs 10
