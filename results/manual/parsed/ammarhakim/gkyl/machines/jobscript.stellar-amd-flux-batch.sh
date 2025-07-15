#!/bin/bash
#FLUX: --job-name=carnivorous-house-7410
#FLUX: --priority=16

export gComDir='$HOME/gkylsoft/gkyl/bin'

module load gcc/8
module load cudatoolkit/12.0
module load openmpi/cuda-11.1/gcc/4.1.1
module load anaconda3/2020.11
export gComDir="$HOME/gkylsoft/gkyl/bin"
echo 'srun -n 1 --gpus 2 '$gComDir'/gkyl -g input_file.lua'
srun -n 1 --gpus 2 $gComDir/gkyl -g input_file.lua
exit 0
