#!/bin/bash
#FLUX: --job-name=3DU
#FLUX: --priority=16

echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
nvidia-smi
module load anaconda3
module list
source activate pytorch
python3 train.py
echo "Ending script..."%                            
