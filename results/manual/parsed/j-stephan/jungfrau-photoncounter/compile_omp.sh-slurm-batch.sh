#!/bin/bash
#SBATCH --job-name=OpenMP_Compile
#SBATCH --output=log.oc.slurm-%j.out
#SBATCH --error=err.oc.slurm-%j.out
#SBATCH --mail-user=j.schenke@hzdr.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=15g
#SBATCH --time=01:00:00

export alpaka_DIR='/home/schenk24/workspace/alpaka/install/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/install/
module load git intel cmake boost python
mkdir -p build_omp
cd build_omp
cmake .. -DCMAKE_BUILD_TYPE=Release -DBENCHMARKING_ENABLED=ON -DALPAKA_ACC_GPU_CUDA_ENABLE=OFF -DCMAKE_C_FLAGS_RELEASE="-O3 -march=native -DNDEBUG" -DCMAKE_CXX_FLAGS_RELEASE="-O3 -march=native -DNDEBUG"
make -j
