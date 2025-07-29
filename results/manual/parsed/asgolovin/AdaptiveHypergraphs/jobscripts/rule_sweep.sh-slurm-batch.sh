#!/bin/bash
#SBATCH --job-name=prop_voting_rts_p_sweep
#SBATCH --output=./output/%j.%x.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=28

module load slurm_setup
module load julia/1.8.2
mpiexec -n 112 julia --project="." -- ./scripts/main.jl ../input/cluster/prop_voting_rts.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode,MaxRSS
