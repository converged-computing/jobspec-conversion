#!/bin/bash
#FLUX: --job-name="eeg_proc"
#FLUX: --priority=16

nvidia-smi
conda env list
spack load cuda/gypzm3r
spack load cudnn
source activate torchpip
srun python3 ../SlitCNNModels/eeg.py
