#!/bin/bash
#FLUX: --job-name=dp2
#FLUX: -c=12
#FLUX: -t=19200
#FLUX: --priority=16

module purge
module load python/intel/3.8.6
module load anaconda3/2020.07
module load cuda/11.3.1
eval "$(conda shell.bash hook)"
conda activate pytorchGPU
cd /home/jy3690/hw5
python3 ./lab2.py --order 15
