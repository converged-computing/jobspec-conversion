#!/bin/bash
#FLUX: --job-name=wandb-sweep
#FLUX: --queue=gpu-8
#FLUX: -t=43200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
conda activate usb2
python --version
which python
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
nvidia-smi -L
sweep_id="dpgkapyt"
wandb agent koffi-anderson/usb_side_channel/${sweep_id}
