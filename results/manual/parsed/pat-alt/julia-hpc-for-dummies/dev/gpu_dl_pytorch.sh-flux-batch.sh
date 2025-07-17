#!/bin/bash
#FLUX: --job-name=rainbow-cupcake-5385
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

module load 2022r2 openmpi py-torch
srun python gpu_dl_pytorch.py > gpu_dl_pytorch.log
