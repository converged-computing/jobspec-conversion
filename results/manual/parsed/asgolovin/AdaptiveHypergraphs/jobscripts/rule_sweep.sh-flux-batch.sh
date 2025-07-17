#!/bin/bash
#FLUX: --job-name=prop_voting_rts_p_sweep
#FLUX: -N=4
#FLUX: --queue=cm2_tiny
#FLUX: -t=72000
#FLUX: --urgency=16

module load slurm_setup
module load julia/1.8.2
mpiexec -n 112 julia --project="." -- ./scripts/main.jl ../input/cluster/prop_voting_rts.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode,MaxRSS
