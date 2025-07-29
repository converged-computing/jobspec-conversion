#!/bin/bash
#SBATCH --job-name=gpu test
#SBATCH --output=run.out
#SBATCH --error=run.err
#SBATCH --mail-user=msussman@fsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:04:00
#SBATCH --partition=genacc_q

echo module load cuda-12.2
module load cuda-12.2
module list 
echo nvcc --version
nvcc --version
echo /usr/bin/nvidia-smi -L
/usr/bin/nvidia-smi -L
echo /usr/bin/nvidia-smi --query-gpu=gpu_name,gpu_bus_id,vbios_version --format=csv
/usr/bin/nvidia-smi --query-gpu=gpu_name,gpu_bus_id,vbios_version --format=csv
echo /usr/bin/nvidia-smi --query-gpu=timestamp,name,pci.bus_id,driver_version --format=csv
/usr/bin/nvidia-smi --query-gpu=timestamp,name,pci.bus_id,driver_version --format=csv
gcc --version 
srun ~/CNSWAVE/CNSWAVE inputs
