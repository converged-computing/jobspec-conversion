#!/bin/bash
#SBATCH --account=csmpistud
#SBATCH --output=opencl.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:nvidia_a30:1
#SBATCH --time=00:05:00
#SBATCH --partition=csmpi_fpga_short

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
BUILD=RELEASE make bin/square_cl
bin/square_cl > results/square.txt
