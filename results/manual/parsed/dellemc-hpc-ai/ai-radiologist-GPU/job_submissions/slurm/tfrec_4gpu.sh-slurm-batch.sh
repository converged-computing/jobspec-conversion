#!/bin/bash
#SBATCH --job-name=tfrec_4gpu
#SBATCH --output=outputs/tfrec_4gpu-%J.o
#SBATCH --error=outputs/tfrec_4gpu-%J.o
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=15:00:00
#SBATCH --partition=gpuq
#SBATCH --constraint=c4140,m,32gb,v100

export LD_LIBRARY_PATH='$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$LD_LIBRARY_PATH'
export PATH='$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$PATH'
export OMPI_MCA_btl_openib_allow_ib='1'

mkdir -p outputs
module load cuda10.0/toolkit/10.0.130
module load gcc/7.2.0
source  activate docker_pip2 
export LD_LIBRARY_PATH=$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$LD_LIBRARY_PATH
export PATH=$HOME/cuda:$HOME/cuda/include:$HOME/cuda/lib64:$HOME/modules/openmpi-4.0.0-flags-ucx/bin:$HOME/modules/openmpi-4.0.0-flags-ucx/include:$PATH
export OMPI_MCA_btl_openib_allow_ib=1
mpirun -np 4 --map-by socket  python chexnet_densenet_tfrec.py --batch_size=64  --epochs=10 --skip_eval=1 --write_weights=0
