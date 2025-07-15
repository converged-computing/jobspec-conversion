#!/bin/bash
#FLUX: --job-name=conspicuous-caramel-3587
#FLUX: -t=174180
#FLUX: --priority=16

module load python/3.10.2 cuda nccl
module load gcc/9.3.0 arrow
sh ./produce_dataset.sh
