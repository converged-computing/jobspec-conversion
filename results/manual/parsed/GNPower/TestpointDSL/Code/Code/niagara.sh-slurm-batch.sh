#!/bin/bash
#SBATCH --job-name=project
#SBATCH --output=project_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module load intel/2019u4
module load cmake/3.21.4
module load python/3.11.5
pip install matplotlib
./build.sh
./run.sh
