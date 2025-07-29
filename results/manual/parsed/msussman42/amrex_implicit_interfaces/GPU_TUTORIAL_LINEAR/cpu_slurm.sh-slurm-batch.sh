#!/bin/bash
#SBATCH --job-name=cpu test
#SBATCH --output=cpurun.out
#SBATCH --error=cpurun.err
#SBATCH --mail-user=msussman@fsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:04:00

echo module load cuda-12.2
module load cuda-12.2
module list 
echo nvcc --version
nvcc --version
echo /usr/bin/nvidia-smi -L
echo /usr/bin/nvidia-smi --query-gpu=gpu_name,gpu_bus_id,vbios_version --format=csv
echo /usr/bin/nvidia-smi --query-gpu=timestamp,name,pci.bus_id,driver_version --format=csv
gcc --version 
srun ~/CNSWAVE/CNS_CPU inputs
