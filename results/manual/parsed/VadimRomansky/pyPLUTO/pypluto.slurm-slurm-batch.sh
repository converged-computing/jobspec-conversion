#!/bin/bash
#SBATCH --job-name=pyPLUTO1
#SBATCH --output=pic-%j.out
#SBATCH --error=pic-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00
#SBATCH --partition=tornado

export OMP_NUM_THREADS='1'

module load python/3.5.2 mpi/openmpi/3.0.0/gcc/7.2.0 library/hdf5/1.10.1/gcc72
export OMP_NUM_THREADS=1
python3 /home/ipntsr/romansky/PLUTO1/Tools/pyPLUTO/main.py
