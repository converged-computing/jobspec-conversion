#!/bin/bash
#FLUX: --job-name=dask-scheduler
#FLUX: --queue=boost_usr_prod
#FLUX: -t=2400
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
dask-scheduler --scheduler-file $HOME/scheduler.json --port 8889 --dashboard-address 8781
sleep 36000
