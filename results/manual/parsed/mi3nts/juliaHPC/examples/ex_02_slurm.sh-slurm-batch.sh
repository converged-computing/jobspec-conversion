#!/bin/bash
#SBATCH --job-name=factorialFunctionSimple
#SBATCH --output=logs/factorialFunctionSimple.%j.out
#SBATCH --error=logs/factorialFunctionSimple.%j.err
#SBATCH --mail-user=lhw150030@utdallas.edu
#SBATCH --mail-type=begin
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00

echo Running on host: `hostname`
julia ex_02_factorial_function_simple.jl
