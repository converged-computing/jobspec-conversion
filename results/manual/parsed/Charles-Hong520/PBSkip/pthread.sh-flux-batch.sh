#!/bin/bash
#FLUX: --job-name=seq and par parse zz.prof
#FLUX: -c=64
#FLUX: -t=87300
#FLUX: --urgency=16

lscpu
date
module load cmake
module load gcc
module load protobuf/
protoc --proto_path=src/schema/ --cpp_out=src/schema/ profile.proto
cd src/pthreads/
rm -rf build
mkdir build
cd build
cmake ..
make
cd ../../../
echo "------------------Running the pthreads version---------------------"
for i in {1..5}; do ./src/pthreads/build/ProfileProject; done
hostname
