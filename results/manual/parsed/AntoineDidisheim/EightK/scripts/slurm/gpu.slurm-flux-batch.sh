#!/bin/bash
#FLUX: --job-name=gpu_single
#FLUX: -c=4
#FLUX: --queue=gpu-a100
#FLUX: -t=600
#FLUX: --urgency=16

module load foss/2022a
module load GCC/11.3.0
module load CUDA/11.7.0
module load GCCcore/11.3.0; module load Python/3.10.4
source /home/adidishe/EightK/venv/bin/activate
TensorFlow/2.11.0-CUDA-11.7.0
python3 gpu_explore.py
