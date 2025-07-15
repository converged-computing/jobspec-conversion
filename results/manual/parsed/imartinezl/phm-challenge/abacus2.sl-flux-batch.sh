#!/bin/bash
#FLUX: --job-name=salted-nalgas-4406
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=1209600
#FLUX: --urgency=16

export CXX='g++'

module load Miniconda3/4.9.2
module load CUDA/11.1.1-GCC-10.2.0
source activate .venv2
export CXX=g++
srun python run.py
