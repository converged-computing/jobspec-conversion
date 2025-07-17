#!/bin/bash
#FLUX: --job-name=psycho-cherry-4451
#FLUX: -c=5
#FLUX: --urgency=16

echo test1
module load anaconda/2020b cuda/10.2 nccl/2.5.6-cuda10.2
echo test2
echo test3
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python main.py btcvae_cardamage_128 -d cardamagemedium -b 64 -l btcvae --lr 0.001 -e 200 --checkpoint-every 10 --task-id $SLURM_ARRAY_TASK_ID --task-count $SLURM_ARRAY_TASK_COUNT
