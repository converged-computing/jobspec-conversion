#!/bin/bash
#FLUX: --job-name=cowy-toaster-3835
#FLUX: --priority=16

export LD_LIBRARY_PATH='$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$LD_LIBRARY_PATH'
export PATH='$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$PATH'
export OMPI_MCA_btl_openib_allow_ib='1'

mkdir -p outputs
mkdir -p saved_weights
module load cuda10.0/toolkit/10.0.130
module load gcc/7.2.0
source  activate docker_pip2 
export LD_LIBRARY_PATH=$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$LD_LIBRARY_PATH
export PATH=$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$PATH
export OMPI_MCA_btl_openib_allow_ib=1
mpirun -np 1 --map-by socket python chexnet_densenet_raw_images.py --batch_size=64  --epochs=10 --skip_eval=1 --write_weights=0
