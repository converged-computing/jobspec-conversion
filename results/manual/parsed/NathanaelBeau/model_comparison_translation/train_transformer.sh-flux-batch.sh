#!/bin/bash
#FLUX: --job-name=wmt-en2de
#FLUX: -c=40
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load anaconda-py3/2019.03
conda activate modelcomparisontranslation
set -x
nvidia-smi
srun accelerate launch --multi_gpu train_mp_transformer.py
