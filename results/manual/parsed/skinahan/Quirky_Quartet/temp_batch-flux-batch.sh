#!/bin/bash
#FLUX: --job-name=tune_t5_codexglue
#FLUX: --urgency=16

export INCLUDEPATH='$INCLUDEPATH:$HOME/cuda/include'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$HOME/cuda/lib64'

module load cuda/11.6.0
module load rclone/1.43
module load blas/3.7.0
module load OpenBLAS/0.3.19
export INCLUDEPATH=$INCLUDEPATH:$HOME/cuda/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/cuda/lib64
echo "Running!
"
env
module list
nvcc --version
nvidia-smi
./run tune_t5_codexglue 
