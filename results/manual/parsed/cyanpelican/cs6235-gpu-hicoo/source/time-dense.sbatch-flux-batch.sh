#!/bin/bash
#FLUX: --job-name=gpu-hicoo
#FLUX: --queue=soc-gpu-kp
#FLUX: -t=14400
#FLUX: --priority=16

echo $0
echo
ulimit -c unlimited -s
module load cuda
nvidia-smi
echo VISIBLE === $CUDA_VISIBLE_DEVICES
./HiCooExperiment 8      4
./HiCooExperiment 1024   8 dense-32x32x32
./HiCooExperiment 16384                           # cpu is ok
./HiCooExperiment 16384  8 dense-256x256x256d.1   NOCPU # takes forever to do dense
./HiCooExperiment 16384  8 dense-128x128x128d.1   
echo TESTS COMPLETED
