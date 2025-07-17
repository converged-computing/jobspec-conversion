#!/bin/bash
#FLUX: --job-name=psycho-soup-1987
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

echo 'slurm allocates gpus ' $CUDA_VISIBLE_DEVICES
module load matlab/R2020a
ndim=12000;
nloop=1000;
 matlab -nodisplay -r  \
  "gpuTest1(${ndim},${nloop},'${SLURM_JOB_ID}');exit;"
