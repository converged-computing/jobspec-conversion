#!/bin/bash
#SBATCH --job-name=openacc_guide_kernels
#SBATCH --account=<your
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=512M
#SBATCH --time=00:05:00
#SBATCH --partition=accel

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module load NVHPC/20.7  # Load Nvidia HPC SDK with profiler
module list  # List modules for easier debugging
nsys profile -t cuda,openacc -f true -o kernels ./jacobi
