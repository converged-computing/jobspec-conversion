#!/bin/bash
#FLUX: --job-name=seq and par parse zz.prof
#FLUX: -c=64
#FLUX: -t=87300
#FLUX: --urgency=16

export PBS_NUM_THREADS='64'

lscpu
date
module load cmake
module load gcc
module load protobuf/
protoc --proto_path=src/schema/ --cpp_out=src/schema/ profile.proto
cd src/sequential/
rm -rf build
mkdir build
cd build
cmake ..
make
cd ../../parallel/
rm -rf build
mkdir build
cd build
cmake ..
make
cd ../../google_api/
rm -rf build
mkdir build
cd build
cmake ..
make
cd ../../pthreads/
rm -rf build
mkdir build
cd build
cmake ..
make
cd ../../dac/
rm -rf build
mkdir build
cd build
cmake ..
make
cd ../../../
export PBS_NUM_THREADS=2
echo "------------------Running the 2 pthreads version-------------------"
for i in {1..10}; do ./src/pthreads/build/ProfileProject; done
export PBS_NUM_THREADS=4
echo "------------------Running the 4 pthreads version-------------------"
for i in {1..10}; do ./src/pthreads/build/ProfileProject; done
export PBS_NUM_THREADS=8
echo "------------------Running the 8 pthreads version-------------------"
for i in {1..10}; do ./src/pthreads/build/ProfileProject; done
export PBS_NUM_THREADS=16
echo "------------------Running the 16 pthreads version------------------"
for i in {1..10}; do ./src/pthreads/build/ProfileProject; done
export PBS_NUM_THREADS=32
echo "------------------Running the 32 pthreads version------------------"
for i in {1..10}; do ./src/pthreads/build/ProfileProject; done
export PBS_NUM_THREADS=64
echo "------------------Running the 64 pthreads version------------------"
for i in {1..10}; do ./src/pthreads/build/ProfileProject; done
echo "------------------Running the Sequential verison-------------------"
for i in {1..10}; do ./src/sequential/build/ProfileProject; done
echo "------------------Running the Parallel verison---------------------"
for i in {1..10}; do ./src/parallel/build/ProfileProject; done
echo "------------------Running the Google API verison-------------------"
for i in {1..10}; do ./src/google_api/build/ProfileProject; done
echo "------------------Running the DAC verison-------------------"
for i in {1..10}; do ./src/dac/build/ProfileProject; done
hostname
