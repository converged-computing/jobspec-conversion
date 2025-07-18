#!/bin/bash
#FLUX: --job-name=angry-cat-6099
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load anaconda
module load anaconda/2020.11-py38
module load cuda/11.7.0
module load cudnn/cuda-11.7_8.6
module load use.own
module load conda-env/my_tf_env-py3.8.5
python control.py
