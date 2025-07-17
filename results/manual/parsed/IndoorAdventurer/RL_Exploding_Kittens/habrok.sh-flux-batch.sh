#!/bin/bash
#FLUX: --job-name=drl😺
#FLUX: -c=5
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

module purge
module load Python/3.10.8-GCCcore-12.2.0
source $HOME/.envs/ek_drl_env/bin/activate
python $1
deactivate
