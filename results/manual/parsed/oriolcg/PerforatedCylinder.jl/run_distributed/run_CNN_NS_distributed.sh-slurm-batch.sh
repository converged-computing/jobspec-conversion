#!/bin/bash
#SBATCH --job-name=PerforatedCylinder
#SBATCH --account=research-ceg-he
#SBATCH --output=slurm-%j-%4t.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3G
#SBATCH --time=3-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=48

source ../compile/modules.sh
mpiexecjl --project=../ -n 48 $HOME/progs/install/julia/1.7.2/bin/julia -J ../PerforatedCylinder_serial.so -O3 --check-bounds=no -e 'include("run_PerforatedCylinder_distributed.jl")'
