#!/bin/bash
#FLUX: --job-name=dask-worker
#FLUX: -t=900
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
dask-cuda worker 10.10.0.135:8889
dask-cuda worker 10.10.0.135:8889
sleep 36000
