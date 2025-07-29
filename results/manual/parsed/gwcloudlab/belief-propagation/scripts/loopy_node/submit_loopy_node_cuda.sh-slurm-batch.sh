#!/bin/bash
#SBATCH --job-name=LoopyNodeCudaBeliefPropagationBenchmarks
#SBATCH --output=loopy_node_cuda_benchmarks%j.out
#SBATCH --error=loopy_node_cuda_benchmarks%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=07:00:00
#SBATCH --partition=gpu

module load cuda/toolkit
module load libxml2
module load cmake
cd ${HOME}/belief-propagation/src/cuda_benchmark
cmake . -DCMAKE_BUILD_TYPE=Release
make clean && make
rm -f *csv
./cuda_node_benchmark
