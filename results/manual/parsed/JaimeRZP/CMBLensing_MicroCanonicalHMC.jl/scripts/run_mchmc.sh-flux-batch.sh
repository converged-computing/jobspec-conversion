#!/bin/bash
#FLUX: --job-name=stinky-dog-9071
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

srun /global/homes/j/jaimerz/.julia/juliaup/julia-1.9.0-rc2+0.x64.linux.gnu/bin/julia MCHMC.jl $(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
exit 0
CMBLensing.stop_MPI_workers()
