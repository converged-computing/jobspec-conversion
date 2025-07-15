#!/bin/bash
#FLUX: --job-name=LLSWEEP
#FLUX: -c=24
#FLUX: -t=21600
#FLUX: --priority=16

module load tensorflow
source $HOME/envs/ll/bin/activate
cd $HOME/lateral-line
python3 ./generate_data.py $*
srun python3 ./sweep.py $*
