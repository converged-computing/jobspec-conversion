#!/bin/bash
#FLUX: --job-name=conspicuous-truffle-4731
#FLUX: -t=1800
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load GCCcore/11.3.0
module load CMake/3.23.1
module load CUDA/11.7.0
HOME_PATH=`pwd`
mkdir -p build
cmake -DCMAKE_BUILD_TYPE=Release -DVISUALISATION=OFF -DSEATBELTS=OFF -DCUDA_ARCH="80" -S $HOME_PATH/.. -B $HOME_PATH/build
cd build
cmake --build . --target all --parallel 4
