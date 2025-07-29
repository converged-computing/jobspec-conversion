#!/bin/bash
#SBATCH --job-name=HPL
#SBATCH --output=hpl_dp_N13_m96-%j.txt
#SBATCH --error=hpl_dp_N13_m96-%j.txt
#SBATCH --nodes=13
#SBATCH --ntasks=25
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=fpga
#SBATCH --constraint=20.4.0_max
#SBATCH --nodelist=fpga-0001,fpga-0002,fpga-0003,fpga-0004,fpga-0005,fpga-0006,fpga-0007,fpga-0008,fpga-0011,fpga-0012,fpga-0013,fpga-0014,fpga-0015

module load intel intelFPGA_pro/21.2.0 bittware_520n/20.4.0_max devel/CMake/3.15.3-GCCcore-8.3.0
srun ../../synthesis_artifacts/LINPACK_DP/520n-21.2.0-20.4.0-iec/Linpack_intel -f ../../synthesis_artifacts/LINPACK_DP/520n-21.2.0-20.4.0-iec/hpl_torus_intel.aocx -n 10 -m 96
