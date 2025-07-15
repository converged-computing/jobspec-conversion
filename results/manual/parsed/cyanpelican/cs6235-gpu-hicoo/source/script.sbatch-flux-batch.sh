#!/bin/bash
#FLUX: --job-name=gpu-hicoo
#FLUX: --queue=soc-gpu-kp
#FLUX: -t=1800
#FLUX: --priority=16

ulimit -c unlimited -s
nvidia-smi
echo VISIBLE === $CUDA_VISIBLE_DEVICES
./HiCooExperiment        8
./HiCooExperiment 1024   8 dense-32x32x32
./HiCooExperiment 32     8 datasets/nell-1.tns NOCPU
echo TESTS COMPLETED
