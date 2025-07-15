#!/bin/bash
#FLUX: --job-name=fugly-dog-1970
#FLUX: --priority=16

module load rocm
cd $HOME/HPCTrainingExamples/HIP/vectorAdd
mkdir build && cd build
cmake ..
make vectoradd
./vectoradd
