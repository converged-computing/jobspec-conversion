#!/bin/bash
#FLUX: --job-name=gkyl
#FLUX: --queue=regular
#FLUX: -t=1800
#FLUX: --urgency=16

export gComDir='/global/homes/m/jdoe/gkylsoft/gkyl/bin'

module load python/3.9-anaconda-2021.11
module load openmpi/5.0.0rc12
module load cudatoolkit/12.0
module load nccl/2.18.3-cu12
module unload darshan
export gComDir="/global/homes/m/jdoe/gkylsoft/gkyl/bin"
echo 'srun --mpi=pmix -n 2 --gpus 2 '$gComDir'/gkyl -g input_file.lua'
srun --mpi=pmix -n 2 --gpus 2 $gComDir/gkyl -g input_file.lua
exit 0
