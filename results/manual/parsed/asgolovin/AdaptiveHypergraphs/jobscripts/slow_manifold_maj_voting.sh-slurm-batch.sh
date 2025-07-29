#!/bin/bash
#SBATCH --job-name=slow_man_maj_rtr
#SBATCH --output=./output/%j.%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00
#SBATCH --partition=cm2_tiny
#SBATCH --constraint=ntasks-per-node=28

module load slurm_setup
module load julia/1.8.2
mpiexec -n $SLURM_NTASKS julia --project="." -- ./scripts/main.jl ../input/cluster/slow_manifold_maj_voting_rtr.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode,MaxRSS
