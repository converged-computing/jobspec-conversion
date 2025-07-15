#!/bin/bash
#FLUX: --job-name=dask-scheduler
#FLUX: -c=2
#FLUX: -t=1200
#FLUX: --urgency=16

source $HOME/Conda_init.txt
module load profile/deeplrn
module load cuda/11.8
module load gcc/11.3.0
module load openmpi/4.1.4--gcc--11.3.0-cuda-11.8  
module load llvm/13.0.1--gcc--11.3.0-cuda-11.8  
module load nccl/2.14.3-1--gcc--11.3.0-cuda-11.8
module load gsl/2.7.1--gcc--11.3.0-omp
conda activate /leonardo_scratch/large/usertrain/$USER/env/SMR3935
CUDA_VISIBLE_DEVICES=0 dask-worker --nthreads 2 --worker-class dask_cuda.CUDAWorker --scheduler-file $HOME/scheduler.json --interface ib0 --port 8889
CUDA_VISIBLE_DEVICES=1 dask-worker --nthreads 2 --worker-class dask_cuda.CUDAWorker --scheduler-file $HOME/scheduler.json --interface ib0 --port 8889
CUDA_VISIBLE_DEVICES=2 dask-worker --nthreads 2 --worker-class dask_cuda.CUDAWorker --scheduler-file $HOME/scheduler.json --interface ib0 --port 8889
CUDA_VISIBLE_DEVICES=3 dask-worker --nthreads 2 --worker-class dask_cuda.CUDAWorker --scheduler-file $HOME/scheduler.json --interface ib0 --port 8889
sleep 36000
