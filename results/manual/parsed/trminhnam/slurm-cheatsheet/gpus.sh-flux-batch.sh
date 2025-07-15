#!/bin/bash
#FLUX: --job-name=gpu_check
#FLUX: -t=60
#FLUX: --priority=16

module load anaconda/3
conda env list
activate viglue
python -c 'import torch; print(torch.cuda.is_available())'
python -m bitsandbytes
nvidia-smi
