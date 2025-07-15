#!/bin/bash
#FLUX: --job-name="best_models220_RNN.Hybrid3D"
#FLUX: -c=12
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_NUM_THREADS='12'
export CRAY_CUDA_MPS='1'
export NCCL_DEBUG='INFO'
export NCCL_IB_HCA='ipogif0'
export NCCL_IB_CUDA_SUPPORT='1'

export OMP_NUM_THREADS=12
export CRAY_CUDA_MPS=1
export NCCL_DEBUG=INFO
export NCCL_IB_HCA=ipogif0
export NCCL_IB_CUDA_SUPPORT=1
module load daint-gpu
module load cray-python/3.6.5.7
module load Horovod/0.18.1-CrayGNU-19.10-tf-2.0.0
module load TensorFlow/2.0.0-CrayGNU-19.10-cuda-10.1.168
srun python3 best_models.py 	--removed_average 1 \
				--dimensionality 3 \
				--data_location /scratch/snx3000/dprelogo/data/ \
				--saving_location /scratch/snx3000/dprelogo/models/ \
				--model RNN.Hybrid3D \
