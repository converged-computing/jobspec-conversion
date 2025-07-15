#!/bin/bash
#FLUX: --job-name=Muesli2-examples-GPU
#FLUX: --exclusive
#FLUX: --queue=gpu2080
#FLUX: -t=14400
#FLUX: --urgency=16

cd /home/k/kuchen/Muesli2
module load intelcuda/2019a
module load CMake/3.15.3
./build.sh
for file in /home/k/kuchen/Muesli2/build/bin/*gpu
do
  mpirun $file
done
wait
