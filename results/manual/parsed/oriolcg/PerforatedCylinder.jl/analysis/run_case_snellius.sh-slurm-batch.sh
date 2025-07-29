#!/bin/bash
#SBATCH --job-name=perf_cylinder
#SBATCH --output=stdout/slurm-%j-%4t.out
#SBATCH --error=stdout/slurm-%j-%4t.err
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

export CASE_ID='$1'

source ../compile/modules_snellius.sh
export CASE_ID=$1
echo "Starting case: $CASE_ID"
mpiexecjl --project=../ -n 12 julia -J ../PerforatedCylinder_parallel.so -O3 --check-bounds=no -e 'include("run_case.jl")'
