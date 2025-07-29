#!/bin/bash
#SBATCH --job-name=motif_intersection
#SBATCH --output=./output/%j.%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --partition=cm2_tiny

module load slurm_setup
module load julia/1.8.2
mpiexec -n 5 julia --project="." -- ./scripts/main.jl ../input/cluster/motif_intersection.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode
