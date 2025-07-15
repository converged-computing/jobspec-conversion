#!/bin/bash
#FLUX: --job-name=conspicuous-squidward-5625
#FLUX: --priority=16

module purge
module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
srun python mwms.py
