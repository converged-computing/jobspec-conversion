#!/bin/bash
#FLUX: --job-name=training
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

nvidia-smi
export CUDA_VISIBLE_DEVICES=0,1,2,3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
source {VIRTUAL ENV ACTIVATE SCRIPT HERE}
cd {PROJECT DIR HERE}
tensorboard --logdir="{GAN OUTPUT DIR HERE}/TensorBoard" --host 0.0.0.0 --load_fast false &
python src/main.py --config {CONFIG_FILE_HERE} --train
