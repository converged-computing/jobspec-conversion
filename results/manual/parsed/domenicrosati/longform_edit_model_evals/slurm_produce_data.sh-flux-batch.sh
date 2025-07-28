#!/bin/bash
#FLUX: --job-name=grated-diablo-7868
#FLUX: -t=174180
#FLUX: --urgency=16

module load python/3.10.2 cuda nccl
module load gcc/9.3.0 arrow
sh ./produce_dataset.sh
