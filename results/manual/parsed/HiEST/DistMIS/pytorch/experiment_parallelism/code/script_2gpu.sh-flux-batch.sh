#!/bin/bash
#FLUX: --job-name=raytune_2gpu
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: -t=54000
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

module purge; module load gcc/8.3.0 cuda/10.2 cudnn/7.6.4 nccl/2.4.8 tensorrt/6.0.1 openmpi/4.0.1 atlas/3.10.3 scalapack/2.0.2 fftw/3.3.8 szip/2.1.1 ffmpeg/4.2.1 opencv/4.1.1 python/3.7.4_ML ray/1.4.1
export PYTHONUNBUFFERED=1
ray start --head --num-cpus=20 --num-gpus=2
python train.py -c ../config/2gpu/config.json
