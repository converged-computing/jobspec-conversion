#!/bin/bash
#FLUX: --job-name=doopy-mango-9711
#FLUX: --queue=batch
#FLUX: -t=300
#FLUX: --urgency=16

module load PrgEnv-amd
module load craype-accel-amd-gfx90a
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/vAdd_hip
