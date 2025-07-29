#!/bin/bash
#FLUX: --job-name=phat-car-7998
#FLUX: --queue=LocalQ
#FLUX: -t=600
#FLUX: --urgency=16

module load rocm
cd $HOME/HPCTrainingExamples/HIP/vectorAdd
mkdir build && cd build
cmake ..
make vectoradd
./vectoradd
