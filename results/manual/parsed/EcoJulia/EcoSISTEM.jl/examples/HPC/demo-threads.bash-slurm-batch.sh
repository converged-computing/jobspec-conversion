#!/bin/bash
#SBATCH --account=project0000
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=512GB
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='128'

module load apps/julia
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=128
julia -t 128 --project=examples examples/Africa_run.jl
