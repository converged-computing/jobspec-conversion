#!/bin/bash
#FLUX: --job-name=train-humanoid-sac-gpu-all-big-dist16
#FLUX: -c=160
#FLUX: -t=86400
#FLUX: --urgency=16

module purge;
module load gcc/8.3.0 cuda/10.2 cudnn/7.6.4 nccl/2.4.8 tensorrt/6.0.1 openmpi/4.0.1 atlas/3.10.3 scalapack/2.0.2 fftw/3.3.8 szip/2.1.1 ffmpeg/4.2.1 opencv/4.1.1 python/3.7.4_ML ray/1.1.0;
echo starting
python train-pybulletgym.py --params-file "./trainings/pybulletgym/humanoid-sac-gpu-all-big-dist12.json"
