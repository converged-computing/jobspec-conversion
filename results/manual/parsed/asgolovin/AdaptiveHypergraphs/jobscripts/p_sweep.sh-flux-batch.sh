#!/bin/bash
#FLUX: --job-name=phat-pancake-5144
#FLUX: --queue=cm2_tiny
#FLUX: -t=10800
#FLUX: --priority=16

module load slurm_setup
module load julia/1.8.2
mpiexec -n 24 julia --project="." -- ./scripts/main.jl ../input/cluster/p_sweep.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode
