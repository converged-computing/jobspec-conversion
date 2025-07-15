#!/bin/bash
#FLUX: --job-name=crusty-pancake-1118
#FLUX: --priority=16

export gComDir='$HOME/gkylsoft/gkyl/bin'

module load python/3.9-anaconda-2021.11
module load openmpi/5.0.0rc12
module load cudatoolkit/12.0
module load nccl/2.18.3-cu12
module unload darshan
export gComDir="$HOME/gkylsoft/gkyl/bin"
echo 'srun -n 4 --gpus 4 '$gComDir'/gkyl -g gk-sheath.lua'
srun -n 4 --gpus 4 $gComDir/gkyl -g gk-sheath.lua
exit 0
