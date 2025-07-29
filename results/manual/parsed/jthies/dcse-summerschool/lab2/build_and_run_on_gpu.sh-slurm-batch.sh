#!/bin/bash
#SBATCH --account=research-eemcs-diam
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=00:02:00
#SBATCH --partition=gpu

source trilinos-env-gpu.sh
cd build-gpu
cmake ..
make -j
srun ./tpetra_driver.x
