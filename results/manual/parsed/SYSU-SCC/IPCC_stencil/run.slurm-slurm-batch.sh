#!/bin/bash
#SBATCH --job-name=ipcc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=amd_256
#SBATCH: --exclusive

export LD_LIBRARY_PATH='./lib:$LD_LIBRARY_PATH'

source /public1/soft/modules/module.sh
module load gcc/8.3.0
module load intel/20.4.3
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
./setup-omp.sh
echo "build..."
make
echo ""
echo "running..."
./bin/stencil IPCC.png
