#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --array=0-249%5

module load intel/compiler
module load intel/mkl
module load fftw/impi/3.3.10
foldername="data_$SLURM_ARRAY_TASK_ID"
cd "$foldername"
mpirun -n 16 ./EffPropertyPoly.exe
cd ..
