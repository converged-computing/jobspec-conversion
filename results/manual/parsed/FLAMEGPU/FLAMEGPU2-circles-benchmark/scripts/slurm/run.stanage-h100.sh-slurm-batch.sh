#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:h100:1
#SBATCH --mem=82G
#SBATCH --time=08:00:00
#SBATCH --qos=gpu

export FLAMEGPU2_INC_DIR='_deps/flamegpu2-src/include'

module load GCC/11.3.0
module load CUDA/12.0.0
PROJECT_ROOT=../..
cd $PROJECT_ROOT
cd build
export FLAMEGPU2_INC_DIR=_deps/flamegpu2-src/include
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
./bin/Release/circles-benchmark
