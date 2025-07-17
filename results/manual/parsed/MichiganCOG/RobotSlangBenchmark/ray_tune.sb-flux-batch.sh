#!/bin/bash
#FLUX: --job-name=stinky-blackbean-8297
#FLUX: -c=72
#FLUX: --queue=lgns28
#FLUX: -t=604800
#FLUX: --urgency=16

echo $CUDA_VISIBLE_DEVICES
echo $HOSTNAME
wandb login 3be59e86854e7deac9e39bf127723eb2e4bf834d
cd $SLURM_SUBMIT_DIR
PYTHONPATH=""
source new_env/bin/activate
ulimit -n 50000
python train_raytune.py
