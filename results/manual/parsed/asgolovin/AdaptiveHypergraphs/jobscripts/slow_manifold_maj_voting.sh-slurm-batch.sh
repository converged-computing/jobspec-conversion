#!/bin/bash
#FLUX: --job-name=slow_man_maj_rtr
#FLUX: --queue=cm2_tiny
#FLUX: -t=2400
#FLUX: --urgency=16

module load slurm_setup
module load julia/1.8.2
mpiexec -n $SLURM_NTASKS julia --project="." -- ./scripts/main.jl ../input/cluster/slow_manifold_maj_voting_rtr.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode,MaxRSS
