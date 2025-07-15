#!/bin/bash
#FLUX: --job-name=red-nunchucks-6817
#FLUX: -n=5
#FLUX: --queue=cm2_tiny
#FLUX: -t=18000
#FLUX: --priority=16

module load slurm_setup
module load julia/1.8.2
mpiexec -n 5 julia --project="." -- ./scripts/main.jl ../input/cluster/motif_intersection.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode
