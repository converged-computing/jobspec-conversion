#!/bin/bash
#SBATCH --job-name=mpi_test
#SBATCH --account=csd403
#SBATCH --output=mpi_test.run
#SBATCH --error=mpi_test.err
#SBATCH --mail-user=jchen.6727@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=00:30:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=4

time mpirun -n 4 nrniv -python -mpi init.py
