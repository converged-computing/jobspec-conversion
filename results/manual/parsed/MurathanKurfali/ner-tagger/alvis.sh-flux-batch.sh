#!/bin/bash
#FLUX: --job-name=grated-spoon-3836
#FLUX: -t=86400
#FLUX: --urgency=16

module load CUDA/12.3.0
module load Python/3.11.3-GCCcore-12.3.0
source rise_env/bin/activate
e.g ./run.sh --system-type $1 --bert-name $2
