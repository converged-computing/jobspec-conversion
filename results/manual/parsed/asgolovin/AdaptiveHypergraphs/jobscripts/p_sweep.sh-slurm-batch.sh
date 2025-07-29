#!/bin/bash
#SBATCH --job-name=p_sweep
#SBATCH --output=./output/%j.%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00

module load slurm_setup
module load julia/1.8.2
mpiexec -n 24 julia --project="." -- ./scripts/main.jl ../input/cluster/p_sweep.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode
