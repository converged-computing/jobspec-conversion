#!/bin/bash
#FLUX: --job-name=cl_test
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load --auto profile/deeplrn
module load gcc 
module load openmpi
module load cuda/11.8 
cd /leonardo_work/ICT23_SMR3872/sdigioia/test_env/
source /leonardo/home/userexternal/sdigioia/.bashrc
conda activate /leonardo_work/ICT23_ESP_0/shared-env/MLenv
mpirun -np 8 test-dask-on-GPUs.py
