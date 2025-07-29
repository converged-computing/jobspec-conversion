#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00

module load rocm
cd $HOME/HPCTrainingExamples/HIP/vectorAdd
mkdir build && cd build
cmake ..
make vectoradd
./vectoradd
