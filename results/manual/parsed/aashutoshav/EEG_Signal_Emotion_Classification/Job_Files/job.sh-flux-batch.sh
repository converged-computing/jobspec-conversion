#!/bin/bash
#FLUX: --job-name=eeg_proc
#FLUX: --queue=gpu_v100_2
#FLUX: -t=719
#FLUX: --urgency=16

nvidia-smi
conda env list
spack load cuda/gypzm3r
spack load cudnn
source activate torchpip
srun python3 ../SlitCNNModels/eeg.py
