#!/bin/bash
#FLUX: --job-name=openacc_guide_kernels
#FLUX: --queue=accel
#FLUX: -t=300
#FLUX: --priority=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module load NVHPC/20.7  # Load Nvidia HPC SDK with profiler
module list  # List modules for easier debugging
nsys profile -t cuda,openacc -f true -o kernels ./jacobi
