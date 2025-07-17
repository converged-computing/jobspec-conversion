#!/bin/bash
#FLUX: --job-name=symSynLatentTrain
#FLUX: --queue=gpu-ms
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/cuda/9.0/lib64:/opt/cuda/9.0/cudnn/7.0/lib64'

DIMENSION=$SLURM_ARRAY_TASK_ID
SEED=$1 # use 72, 73, 74
if [ -z "$SEED" ]; then
    echo "Seed argument missing"
    exit 1
fi
echo "################################"
echo "# Latent train dim $DIMENSION, seed $SEED"
echo "################################"
echo
export LD_LIBRARY_PATH=/opt/cuda/9.0/lib64:/opt/cuda/9.0/cudnn/7.0/lib64
.venv/bin/python3 experiment_symbols.py train \
    --model experiment_L${DIMENSION}_${SEED} \
    --symbols datasets/latent/L${DIMENSION}_${SEED} \
    --seed_offset $SEED
echo
echo "########"
echo "# DONE #"
echo "########"
