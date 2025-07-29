#!/bin/bash
#SBATCH --job-name=WuK_scaffold
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

mkdir -p sources/build
cd sources/build
rm -fr *
cmake ..
make
cd ../..
sources/build/main
