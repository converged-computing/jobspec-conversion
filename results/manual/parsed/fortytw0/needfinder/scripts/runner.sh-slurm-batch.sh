#!/bin/bash
#FLUX: --job-name=gpu-job
#FLUX: -n=24
#FLUX: --queue=sgpu
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load cuda
module load cudnn
nvidia-smi
cd /scratch/summit/dasr8731/needfinder
source activate ./venv/
python -m src.train.train
