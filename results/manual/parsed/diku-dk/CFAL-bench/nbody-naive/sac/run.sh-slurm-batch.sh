#!/bin/bash
#SBATCH --account=csmpi
#SBATCH --output=run.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:nvidia_a30:1
#SBATCH --mem=64G
#SBATCH --time=04:00:00

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
make clean
make -j3
echo "Sequential"
bin/nbody_seq
echo "MT"
bin/nbody_mt -mt 32
echo "Cuda"
bin/nbody_cuda
