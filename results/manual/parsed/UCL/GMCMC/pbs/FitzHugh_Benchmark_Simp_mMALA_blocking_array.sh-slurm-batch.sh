#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UCL/GMCMC/pbs/FitzHugh_Benchmark_Simp_mMALA_blocking_array.sh
