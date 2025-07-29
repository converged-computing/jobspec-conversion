#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=80G
#SBATCH --time=04:00:00
#SBATCH --qos=gpu

export FLAMEGPU2_INC_DIR='_deps/flamegpu2-src/include'

module unuse /usr/local/modulefiles/live/eb/all
module unuse /usr/local/modulefiles/live/noeb
module use /usr/local/modulefiles/staging/eb-znver3/all/
module load GCC/11.2.0
module load CUDA/11.4.1
PROJECT_ROOT=../..
cd $PROJECT_ROOT
cd build
export FLAMEGPU2_INC_DIR=_deps/flamegpu2-src/include
nvidia-smi
./bin/Release/ensemble-benchmark
