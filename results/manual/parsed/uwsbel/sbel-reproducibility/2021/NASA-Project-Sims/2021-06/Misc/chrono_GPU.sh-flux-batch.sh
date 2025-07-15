#!/bin/bash
#FLUX: --job-name=rainbow-rabbit-4287
#FLUX: --queue=sbel
#FLUX: -t=259200
#FLUX: --urgency=16

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
module load glfw/3.3.2
module load intel/mkl/2019_U2
module load openmpi/4.0.2
./demo_GPU_ballcosim demo_GPU_ballcosim.json
