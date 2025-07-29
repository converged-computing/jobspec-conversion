#!/bin/bash
#SBATCH --job-name=cnn-NS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=1

source modules.sh
mpiexecjl --project=../ -n 1 $HOME/progs/install/julia/1.7.2/bin/julia -O3 --check-bounds=no --color=yes compile.jl
