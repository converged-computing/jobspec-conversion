#!/bin/bash
#FLUX: --job-name=aco_cuda_p1
#FLUX: --queue=gpu2080
#FLUX: -t=600
#FLUX: --urgency=16

module load GCC/8.2.0-2.31.1
module load GCCcore/8.2.0
module load gcccuda/2019a
module load gompi/2019a
module load Boost/1.70.0
module load CMake/3.15.3
module list
cd /home/b/b_mene01/LS_PI-Research_ACO/build/Release/
cmake -G "Unix Makefiles" -D CMAKE_BUILD_TYPE=Release /home/b/b_mene01/LS_PI-Research_ACO/source/
make
