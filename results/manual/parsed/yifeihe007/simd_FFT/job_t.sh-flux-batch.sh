#!/bin/bash
#FLUX: --job-name=psycho-taco-2450
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load foss
module load CMake
bash test_n.sh
