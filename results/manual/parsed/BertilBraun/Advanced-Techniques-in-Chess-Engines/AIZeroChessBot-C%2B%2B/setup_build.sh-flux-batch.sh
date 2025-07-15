#!/bin/bash
#FLUX: --job-name=setup
#FLUX: --queue=dev_gpu_4
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load devel/cuda/11.6
module load devel/cmake/3.23.3
module load compiler/gnu/11.2
module load mpi/openmpi/4.1
module save chess
if [ ! -d ~/miniconda3/envs/chess ]; then
    echo "Creating conda environment..."
    conda env create -f environment.yaml
fi
source ~/miniconda3/bin/activate chess
LIBTORCH_URL_CUDA="https://download.pytorch.org/libtorch/cu116/libtorch-cxx11-abi-shared-with-deps-1.12.1%2Bcu116.zip"
LIBTORCH_URL_CPU="https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.12.1%2Bcpu.zip"
LIBTORCH_ZIP="libtorch.zip"
mkdir -p libtorch_cuda
mkdir -p libtorch_cpu
if [ ! -f "libtorch_cuda/$LIBTORCH_ZIP" ]; then
    echo "Downloading LibTorch..."
    wget -O "libtorch_cuda/$LIBTORCH_ZIP" "$LIBTORCH_URL_CUDA"
    echo "Extracting LibTorch..."
    unzip -o "libtorch_cuda/$LIBTORCH_ZIP" -d .
fi
if [ ! -f "libtorch_cpu/$LIBTORCH_ZIP" ]; then
    echo "Downloading LibTorch..."
    wget -O "libtorch_cpu/$LIBTORCH_ZIP" "$LIBTORCH_URL_CPU"
    echo "Extracting LibTorch..."
    unzip -o "libtorch_cpu/$LIBTORCH_ZIP" -d .
fi
if [ ! -f "src/json.hpp" ]; then
    echo "Downloading json.hpp..."
    wget -O "src/json.hpp" "https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp"
fi
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ..
cd ..
cp build/compile_commands.json .
echo "Setup completed."
cd train
source train.sh
