#!/bin/bash
#FLUX: --job-name=butterscotch-nalgas-2216
#FLUX: -c=18
#FLUX: -t=86400
#FLUX: --priority=16

cd ~/ermi/categorisation/
module purge
module load anaconda/3/2021.11
module load gcc/11 impi/2021.6
module load cuda/11.6
module load pytorch_distributed/gpu-cuda-11.6/1.13.0
pip3 install tabpfn xgboost
python benchmark/eval.py 
