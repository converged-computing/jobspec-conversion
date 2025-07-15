#!/bin/bash
#FLUX: --job-name=persnickety-parsnip-2810
#FLUX: --urgency=16

module load PrgEnv-cray
module load amd-mixed 
module load craype-accel-amd-gfx90a
srun -N1 -n2 -c4 --gpus-per-task=1 --gpu-bind=closest ./make_build_dir/vAdd_hip
