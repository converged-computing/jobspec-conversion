#!/bin/bash
#FLUX: --job-name=cupy
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load anaconda3/2022.5
conda activate /scratch/network/jdh4/.gpu_workshop/envs/cupy-env
echo "GPU is " $(nvidia-smi -a | grep "Product Name" | awk '{print $(NF)}')
python myscript.py               # case 1
