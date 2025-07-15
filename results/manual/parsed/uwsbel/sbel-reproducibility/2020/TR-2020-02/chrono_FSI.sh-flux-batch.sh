#!/bin/bash
#FLUX: --job-name=sticky-caramel-9834
#FLUX: -t=864000
#FLUX: --urgency=16

module load gcc/7.3.0
module load cmake/3.15.4
module load cuda/10.1
../../chrono-dev-build-gauss/bin/demo_FSI_Rover_granular_NSC demo_FSI_Rover_granular.json
