#!/bin/bash
#SBATCH --job-name=compile.stanage.sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=82G
#SBATCH --time=00:30:00
#SBATCH --qos=gpu

module load GCC/11.3.0
module load CUDA/12.0.0
module load CMake/3.24.3-GCCcore-11.3.0
PROJECT_ROOT=../..
cd $PROJECT_ROOT
mkdir -p build && cd build
cmake .. -DCMAKE_CUDA_ARCHITECTURES="80;90" -DCMAKE_BUILD_TYPE=Release -DFLAMEGPU_SEATBELTS=OFF -DFLAMEGPU_SHARE_USAGE_STATISTICS=OFF
cmake --build . -j `nproc`
