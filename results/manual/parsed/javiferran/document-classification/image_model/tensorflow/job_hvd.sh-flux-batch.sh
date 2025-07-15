#!/bin/bash
#FLUX: --job-name=hvd_tf2
#FLUX: -c=40
#FLUX: -t=3000
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'
export SLURM_MPI_TYPE='openmpi'

module purge; module load gcc/8.3.0 cuda/10.1 cudnn/7.6.4 nccl/2.4.8 tensorrt/6.0.1 openmpi/4.0.1 fftw/3.3.8 ffmpeg/4.2.1 opencv/4.1.1 atlas/3.10.3 scalapack/2.0.2 szip/2.1.1 pytho
n/3.7.4_ML
export PYTHONUNBUFFERED=1
date
export SLURM_MPI_TYPE=openmpi
mpirun -np 1 -bind-to none -map-by slot -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH -mca pml ob1 -mca btl ^openib python horovod_effnet.py --epochs 20 --optimizer sgd --image_model 0
