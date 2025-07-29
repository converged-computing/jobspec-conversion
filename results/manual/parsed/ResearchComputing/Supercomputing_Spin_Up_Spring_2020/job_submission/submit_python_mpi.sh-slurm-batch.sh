#!/bin/bash
#SBATCH --output=python_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --qos=normal

module purge
module load python/3.5.1
module load intel impi   
cd progs
mpirun -np $SLURM_NTASKS python hello1.py
