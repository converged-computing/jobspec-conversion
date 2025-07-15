#!/bin/bash
#FLUX: --job-name=milky-bike-6942
#FLUX: --priority=16

echo "Running on"
hostname
echo "GPU $CUDA_VISIBLE_DEVICES"
docker build . -t nopww
mkdir /output/marlonm/NOPWW_${SLURM_ARRAY_TASK_ID}/
mkdir /output/marlonm/NOPWW_${SLURM_ARRAY_TASK_ID}/models
. ./keys.sh
cd /output/marlonm/NOPWW_${SLURM_ARRAY_TASK_ID}
docker run --rm -e WANDB_API_KEY=$WANDB_API_KEY --user "$(id -u):$(id -g)" -v $(pwd)/models:/workspace/models --cpus 16 --gpus \"device=$CUDA_VISIBLE_DEVICES\" nopww wandb agent $WANDB_SWEEP
cp /output/marlonm/NOPWW_${SLURM_ARRAY_TASK_ID}/models/* /home/marlonm/neural_operator_wind_to_waves/models/
rm -r /output/marlonm/NOPWW_${SLURM_ARRAY_TASK_ID}
