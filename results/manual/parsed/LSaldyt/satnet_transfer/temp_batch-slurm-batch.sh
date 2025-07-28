#!/bin/bash
#FLUX: --job-name=main
#FLUX: -c=32
#FLUX: --queue=wildfire
#FLUX: -t=604800
#FLUX: --urgency=16

export INCLUDEPATH='$INCLUDEPATH:$HOME/cuda/include'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$HOME/cuda/lib64'

module load cuda/11.2.0
module load rclone/1.43
export INCLUDEPATH=$INCLUDEPATH:$HOME/cuda/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/cuda/lib64
echo "Running!
"
env
module list
nvcc --version
nvidia-smi
poetry run pip list
./run main 
