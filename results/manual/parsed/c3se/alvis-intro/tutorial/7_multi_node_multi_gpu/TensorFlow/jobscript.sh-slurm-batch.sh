#!/bin/bash
#FLUX: --job-name=MNMG TensorFlow
#FLUX: -N=2
#FLUX: --queue=alvis
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
srun python mwms.py
