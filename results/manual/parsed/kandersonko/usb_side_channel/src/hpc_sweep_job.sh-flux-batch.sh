#!/bin/bash
#FLUX: --job-name=param-sweep
#FLUX: -t=28800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
nvidia-smi -L
conda activate usb2
python --version
which python
sweep_id=kxh8r98c
srun --exclusive --gres=gpu:2 -l wandb agent koffi-anderson/usb_experiments/${sweep_id}
