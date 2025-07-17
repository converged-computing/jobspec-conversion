#!/bin/bash
#FLUX: --job-name=fuzzy-buttface-5794
#FLUX: --queue=amd-longq
#FLUX: --urgency=16

module purge
module load shared
module load cuda80/blas/8.0.61 cuda80/fft/8.0.61 cuda80/gdk/352.79 cuda80/nsight/8.0.61 cuda80/profiler/8.0.61 cuda80/toolkit/8.0.61 cudnn/6.0
cd /home/ishalyminov/data/dialogue_denoiser && /home/ishalyminov/Envs/dialogue_denoiser/bin/python -m dialogue_denoiser \
  --decode \
  --data_dir ../babi_tools/babi_task6_echo \
  --train_dir ckpt
exit 0
