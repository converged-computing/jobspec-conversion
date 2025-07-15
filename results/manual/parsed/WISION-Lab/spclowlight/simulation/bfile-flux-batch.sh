#!/bin/bash
#FLUX: --job-name=simdata
#FLUX: -c=24
#FLUX: --queue=research
#FLUX: -t=360000
#FLUX: --priority=16

module load anaconda/mini/4.9.2
module load nvidia/cuda/11.3.1
bootstrap_conda
conda activate minienv
which python
hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
top -b -d1 -n1 | grep -i "%Cpu" #This will show cpu utilization at the start of the script
date
python -u create_data.py $1 $2
wait
