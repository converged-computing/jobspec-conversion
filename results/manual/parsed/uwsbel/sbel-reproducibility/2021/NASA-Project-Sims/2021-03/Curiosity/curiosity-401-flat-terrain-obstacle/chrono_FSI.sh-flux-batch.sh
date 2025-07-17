#!/bin/bash
#FLUX: --job-name=loopy-snack-9210
#FLUX: -c=4
#FLUX: --queue=sbel
#FLUX: -t=864000
#FLUX: --urgency=16

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
./demo_FSI_Curiosity_granular_NSC demo_FSI_Curiosity_granular.json 1 0.5 1.0
