#!/bin/bash
#FLUX: --job-name=VB3D-GPU
#FLUX: -c=8
#FLUX: --queue=gpu4
#FLUX: -t=240
#FLUX: --urgency=16

echo "### Starting at: $(date) ###"
module load gcc/gcc-5.4.0
module load eigen/eigen-3.2.7
module load cuda/cuda-10.0.130
source ~/.bashrc
./bin/linux/ReconParallelPipeline_MU_VB3D ./configs/albuquerque.txt
