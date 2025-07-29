#!/bin/bash
#FLUX: --job-name=RNN.SummarySpace3D_simple
#FLUX: -c=12
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

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
module load TensorFlow/1.14.0-CrayGNU-19.10-cuda-10.1.168-python3
module load Horovod/0.16.4-CrayGNU-19.10-tf-1.14.0
srun python3 run_simple.py 	--removed_average 1 \
                            --dimensionality 3 \
                            --data_location $SCRATCH/data/ \
                            --saving_location $SCRATCH/test_runs/models/ \
                            --logs_location $SCRATCH/test_runs/logs/ \
                            --model RNN.SummarySpace3D_simple \
                            --epochs 100 \
                            --gpus 1 \
                            --multi_gpu_correction 2 \
                            --patience 10 \
