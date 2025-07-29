#!/bin/bash
#SBATCH --job-name=swbench
#SBATCH --output=gemm_log_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=00:45:00
#SBATCH --constraint=cascade

THREADS=20
module load NiaEnv/.2022a
module load intel/2022u2
module load cmake
module load gcc
echo "----- Building swbench -----"
rm -rf build
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DPAPI_PREFIX=${HOME}/programs/papi/  ..
cmake --build . --config Release -- -j4
