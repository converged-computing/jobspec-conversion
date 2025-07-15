#!/bin/bash
#FLUX: --job-name=faux-pot-4274
#FLUX: --queue=commons
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load GCC/5.4.0 OpenMPI/1.10.3 CUDA/7.5.18 TensorFlow/0.10.0
srun python NNetwork.py
