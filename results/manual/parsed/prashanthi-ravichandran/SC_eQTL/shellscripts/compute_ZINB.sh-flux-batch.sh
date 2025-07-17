#!/bin/bash
#FLUX: --job-name=compute_ZINB
#FLUX: -c=3
#FLUX: --queue=gpup100
#FLUX: -t=43200
#FLUX: --urgency=16

module load cuda/9.0
module load python/3.6-anaconda
conda activate tensorflow_gpu_env
python -u ../src/run_ZINB.py --cell-type $1 --n-genes 200 --learning-rate 0.0001 --train-epochs 100000 | tee ../log/compute_ZINB/$1_200_0.0001_100000.log 
