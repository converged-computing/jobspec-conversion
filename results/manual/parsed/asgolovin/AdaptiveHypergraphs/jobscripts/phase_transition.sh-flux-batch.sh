#!/bin/bash
#FLUX: --job-name=quirky-arm-2054
#FLUX: -N=4
#FLUX: --queue=cm2_inter
#FLUX: -t=420
#FLUX: --priority=16

module load slurm_setup
module load julia/1.8.5
echo $LD_LIBRARY_PATH
mpiexec -n 96 julia --project="." -- ./scripts/main.jl ../input/cluster/phase_transition_p_small.jl
sacct -j $SLURM_JOB_ID --format=jobid,start,end,CPUTime,Elapsed,ExitCode
