#!/bin/bash
#SBATCH --job-name=perf_cylinder_3D
#SBATCH --output=stdout/slurm-%j-%4t.out
#SBATCH --error=stdout/slurm-%j-%4t.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=thin

source ../compile/modules_snellius.sh
mpiexecjl --project=../ -n 4 julia -J ../PerforatedCylinder_parallel.so -O3 --check-bounds=no -e 'include("run_3Dcase.jl")'
