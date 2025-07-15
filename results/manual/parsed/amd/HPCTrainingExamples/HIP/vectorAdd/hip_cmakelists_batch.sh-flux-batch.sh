#!/bin/bash
#FLUX: --job-name=angry-frito-4367
#FLUX: --urgency=16

module load rocm
cd $HOME/HPCTrainingExamples/HIP/vectorAdd
mkdir build && cd build
cmake ..
make vectoradd
./vectoradd
