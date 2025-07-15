#!/bin/bash
#FLUX: --job-name=demo_pmace_jax
#FLUX: -t=3600
#FLUX: --urgency=16

module load anaconda/2020.11-py38
module load cudnn/cuda-12.1_8.9
conda activate pmace_jax
nvidia-smi
cd tests/synthetic_image/single_mode/
nohup python noisy_data_reconstruction.py
