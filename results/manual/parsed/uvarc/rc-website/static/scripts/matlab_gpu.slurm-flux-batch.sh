#!/bin/bash
#FLUX: --job-name=faux-nunchucks-0448
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --priority=16

echo 'slurm allocates gpus ' $CUDA_VISIBLE_DEVICES
module load matlab/R2020a
ndim=12000;
nloop=1000;
 matlab -nodisplay -r  \
  "gpuTest1(${ndim},${nloop},'${SLURM_JOB_ID}');exit;"
