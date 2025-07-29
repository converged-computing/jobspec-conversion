#!/bin/bash
#SBATCH --account=tc053
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:02:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu

source /work/tc053/tc053/shared/CUDAQ-workshop-231027/environment.sh
source $CUDAQ_DIR/modules.sh
nvq++ -O3 -o qft-nv64 --target nvidia-fp64 $CUDAQ_DIR/examples/qft.cpp
srun ./qft-nv64
