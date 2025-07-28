#!/bin/bash
#FLUX: --job-name=carnivorous-diablo-7133
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export CUDA_LAUNCH_BLOCKING='1'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
export CUDA_LAUNCH_BLOCKING=1
mamba activate cic
python ~/CellularImageClassification/resnet_pretrained.py --t=5 --checkpoint_folder='resnet_checkpoints' -p=False
