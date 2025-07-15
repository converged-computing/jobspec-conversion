#!/bin/bash
#FLUX: --job-name=fmri-ode
#FLUX: --queue=gpu
#FLUX: -t=54000
#FLUX: --urgency=16

module unload Python 
module load miniconda 
module load CUDA/11.1.1-GCC-10.2.0.lua CUDAcore/11.1.1.lua 
module load cuDNN/8.0.5.39-CUDA-11.1.1.lua 
conda activate pytorch_fmri  
python main.py
