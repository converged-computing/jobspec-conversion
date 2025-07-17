#!/bin/bash
#FLUX: --job-name=quirky-banana-3193
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=21600
#FLUX: --urgency=16

srun /global/homes/j/jaimerz/.julia/juliaup/julia-1.9.0-rc2+0.x64.linux.gnu/bin/julia MCHMC.jl $(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
exit 0
CMBLensing.stop_MPI_workers()
