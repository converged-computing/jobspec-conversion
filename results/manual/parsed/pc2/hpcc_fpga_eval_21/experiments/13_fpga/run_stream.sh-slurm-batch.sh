#!/bin/bash
#SBATCH --job-name=stream
#SBATCH --output=stream_N13-%j.out
#SBATCH --error=stream_N13-%j.out
#SBATCH --nodes=13
#SBATCH --ntasks=26
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=fpga
#SBATCH --constraint=20.4.0_hpc

module load intelFPGA_pro/21.2.0 bittware_520n/20.4.0_hpc intel devel/CMake/3.15.3-GCCcore-8.3.0 
srun ../../synthesis_artifacts/STREAM/520n-21.2.0-20.4.0/STREAM_FPGA_intel -f ../../synthesis_artifacts/STREAM/520n-21.2.0-20.4.0/stream_kernels_single.aocx -r 4 -s 1073741824
