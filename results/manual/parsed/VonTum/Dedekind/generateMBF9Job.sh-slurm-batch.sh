#!/bin/bash
#SBATCH --job-name=generateMBF9
#SBATCH --account=pc2-mitarbeiter
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=normal
#SBATCH: --exclusive

module load devel/CMake/3.21.1-GCCcore-11.2.0 fpga bittware/520n intel/opencl_sdk
./production parallelizeMBF9GenerationAcrossAllCores:262144
