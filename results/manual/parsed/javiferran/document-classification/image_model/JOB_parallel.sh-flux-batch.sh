#!/bin/bash
#FLUX: --job-name=b0-1
#FLUX: -c=40
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'
export SLURM_MPI_TYPE='openmpi'

module purge;module load gcc/8.3.0 cuda/10.1 cudnn/7.6.4 nccl/2.4.8 tensorrt/6.0.1 openmpi/4.0.1 fftw/3.3.8 ffmpeg/4.2.1 opencv/4.1.1 atlas/3.10.3 scalapack/2.0.2 szip/2.1.1 python/3.7.4_ML
export PYTHONUNBUFFERED=1
export SLURM_MPI_TYPE=openmpi
python eff_big_training.py \
	--epochs 20 \
	--eff_model b0 \
	--load_path /gpfs/scratch/bsc31/bsc31275/
