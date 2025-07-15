#!/bin/bash
#FLUX: --job-name=red-parsnip-9839
#FLUX: --exclusive
#FLUX: -t=300
#FLUX: --priority=16

module load uppmax
module load python_ML_packages/3.9.5-gpu python/3.9.5 
source <path-to-to-your-virtual-environment>/Example-gpu/bin/activate
srun python pytorch_fitting_gpu.py
