#!/bin/bash
#FLUX: --job-name=job-transformer-mixed-precision
#FLUX: -c=40
#FLUX: -t=14400
#FLUX: --urgency=16

module purge; module load gcc/8.3.0 cuda/10.2 cudnn/7.6.4 nccl/2.4.8 tensorrt/6.0.1 openmpi/4.0.1 atlas scalapack/2.0.2 fftw/3.3.8 szip/2.1.1 ffmpeg/4.2.1 opencv/4.1.1 python/3.7.4_ML arrow/3.0.0 torch/1.9.0a0 text-mining/2.1.0
python main.py --json_file './config_mp.json'
