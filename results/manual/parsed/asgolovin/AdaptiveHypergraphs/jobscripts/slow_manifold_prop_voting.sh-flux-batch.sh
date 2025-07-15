#!/bin/bash
#FLUX: --job-name=creamy-destiny-1606
#FLUX: -N=2
#FLUX: --queue=cm2_tiny
#FLUX: -t=14400
#FLUX: --priority=16

module load slurm_setup
module load julia/1.8.2
mpiexec -n 56 julia --project="." -- ./scripts/main.jl ../input/cluster/slow_manifold_prop_voting_rts.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode,MaxRSS
