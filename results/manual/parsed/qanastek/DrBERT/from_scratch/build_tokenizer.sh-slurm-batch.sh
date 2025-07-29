#!/bin/bash
#FLUX: --job-name=DrBERT
#FLUX: -c=6
#FLUX: --queue=gpu_p2
#FLUX: -t=68400
#FLUX: --urgency=16

module purge
module load pytorch-gpu/py3/1.11.0
nvidia-smi
srun python build_tokenizer.py
