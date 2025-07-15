#!/bin/bash
#FLUX: --job-name=reclusive-peanut-butter-3098
#FLUX: -t=864000
#FLUX: --priority=16

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
./demo_FSI_Viper_granular_NSC demo_FSI_Viper_granular.json 1 0.5 1.0
