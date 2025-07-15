#!/bin/bash
#FLUX: --job-name=lovely-poo-4331
#FLUX: -t=864000
#FLUX: --priority=16

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
../../chrono-dev-build/bin/demo_FSI_Curiosity_granular_NSC demo_FSI_Curiosity_granular.json 1 0.5 1.0
