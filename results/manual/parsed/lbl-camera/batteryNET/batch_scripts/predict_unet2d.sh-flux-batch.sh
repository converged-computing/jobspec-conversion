#!/bin/bash
#FLUX: --job-name=joyous-lemon-6110
#FLUX: -c=32
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

echo "Starting at: $(date)"
module load python
conda activate batteryNET
echo "In conda environment: $CONDA_DEFAULT_ENV"
nvidia-smi
export SLURM_CPU_BIND="cores"
STACK=IM_298-1_$(printf "%03d" $SLURM_ARRAY_TASK_ID)
python predict_2d.py setup_files/xsection-unet2d.json --predict_stack $STACK
echo "Done at : $(date)"
