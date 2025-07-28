#!/bin/bash
#FLUX: --job-name=Threads
#FLUX: -c=14
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load foss
module load CMake
bash test_n.sh
