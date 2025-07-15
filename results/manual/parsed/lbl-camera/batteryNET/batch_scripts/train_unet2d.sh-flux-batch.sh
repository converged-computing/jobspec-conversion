#!/bin/bash
#FLUX: --job-name=expressive-nunchucks-9372
#FLUX: -c=32
#FLUX: -t=3600
#FLUX: --priority=16

export SLURM_CPU_BIND='cores'

echo "Starting at: $(date)"
module load python
conda activate batteryNET
echo "In conda environment: $CONDA_DEFAULT_ENV"
nvidia-smi
export SLURM_CPU_BIND="cores"
python train.py 'setup_files/xsection-unet2d.json' --num_workers 32 --epochs 100
STACK=IM_298-1_240
python predict_2d.py 'setup_files/xsection-unet2d.json' --predict_stack $STACK
echo "Done at : $(date)"
