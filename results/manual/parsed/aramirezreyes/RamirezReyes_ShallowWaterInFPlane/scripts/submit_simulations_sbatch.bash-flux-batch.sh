#!/bin/bash
#FLUX: --job-name=scruptious-butter-3893
#FLUX: --gpus-per-task=1
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

export SLURM_CPU_BIND="cores"
f1=$1
f2=$2
f3=$3
f4=$4
echo The first file is $f1
echo The second file is $f2
echo The third file is $f3
echo The fourth file is $f4
srun --exact -u -n 1 --gpus-per-task 1 --cpus-per-gpu 8 --mem-per-gpu=50G /global/u2/a/aramreye/Software/julia-1.8.5/bin/julia -t 8 --project=@. read_parameter_file_and_launch_simulation.jl $f1 &
srun --exact -u -n 1 --gpus-per-task 1 --cpus-per-gpu 8 --mem-per-gpu=50G /global/u2/a/aramreye/Software/julia-1.8.5/bin/julia -t 8 --project=@. read_parameter_file_and_launch_simulation.jl $f2 &
srun --exact -u -n 1 --gpus-per-task 1 --cpus-per-gpu 8 --mem-per-gpu=50G /global/u2/a/aramreye/Software/julia-1.8.5/bin/julia -t 8 --project=@. read_parameter_file_and_launch_simulation.jl $f3 &
srun --exact -u -n 1 --gpus-per-task 1 --cpus-per-gpu 8 --mem-per-gpu=50G /global/u2/a/aramreye/Software/julia-1.8.5/bin/julia -t 8 --project=@. read_parameter_file_and_launch_simulation.jl $f4 &
wait
