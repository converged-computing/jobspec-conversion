#!/bin/bash
#SBATCH --job-name=compile.bessemer.sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=00:30:00

module use /usr/local/modulefiles/staging/eb/all/
module load CUDA/11.0.2-GCC-9.3.0
module load Anaconda3/5.3.0
conda create -yn fgpu2-ensemble-benchmark
source activate fgpu2-ensemble-benchmark
conda install -y cmake=3.18
PROJECT_ROOT=../..
cd $PROJECT_ROOT
mkdir -p build && cd build
cmake .. -DCMAKE_CUDA_ARCHITECTURES=70 -DCMAKE_BUILD_TYPE=Release -DFLAMEGPU_SEATBELTS=OFF -DFLAMEGPU_SHARE_USAGE_STATISTICS=OFF
cmake --build . -j `nproc`
