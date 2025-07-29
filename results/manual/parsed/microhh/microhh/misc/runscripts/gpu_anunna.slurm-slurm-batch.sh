#!/bin/bash
#SBATCH --job-name=microhh
#SBATCH --output=output_%j.txt
#SBATCH --error=error_%j.txt
#SBATCH --mail-user=name@domain.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=20GB
#SBATCH --time=01:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=V100

module load cuda/10.1
module load netcdf/gcc/64/4.6.1
module load fftw3/gcc/64/3.3.8
module load hdf5/gcc/64/1.10.1
module unload intel
module unload gcc
module load gcc/7.1.0
module unload python
module load python/3.7.1
./microhh init bomex
./microhh run bomex
