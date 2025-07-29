#!/bin/bash
#SBATCH --job-name=aco_cuda_p1
#SBATCH --output=/home/b/b_mene01/outputs/compile.out
#SBATCH --mail-user=b_mene01@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

module load GCC/8.2.0-2.31.1
module load GCCcore/8.2.0
module load gcccuda/2019a
module load gompi/2019a
module load Boost/1.70.0
module load CMake/3.15.3
module list
cd /home/b/b_mene01/LS_PI-Research_ACO/build/Release/
cmake -G "Unix Makefiles" -D CMAKE_BUILD_TYPE=Release /home/b/b_mene01/LS_PI-Research_ACO/source/
make
