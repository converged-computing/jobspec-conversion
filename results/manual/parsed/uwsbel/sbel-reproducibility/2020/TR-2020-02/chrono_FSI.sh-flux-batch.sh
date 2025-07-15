#!/bin/bash
#FLUX: --job-name=confused-noodle-6514
#FLUX: -t=864000
#FLUX: --priority=16

module load gcc/7.3.0
module load cmake/3.15.4
module load cuda/10.1
../../chrono-dev-build-gauss/bin/demo_FSI_Rover_granular_NSC demo_FSI_Rover_granular.json
