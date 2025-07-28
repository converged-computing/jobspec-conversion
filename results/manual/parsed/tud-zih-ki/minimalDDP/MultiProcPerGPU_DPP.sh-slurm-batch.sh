#!/bin/bash
#FLUX: --job-name=TestDDP_GPUBind_MPIDatloader
#FLUX: -N=3
#FLUX: -c=2
#FLUX: --queue=alpha,alpha-interactive
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
ml modenv/hiera 
ml GCC/11.3.0
ml OpenMPI/4.1.4
ml imkl/2022.0.1
ml CUDA/11.7.0
ml cuDNN/8.4.1.50-CUDA-11.7.0
ml NCCL/2.12.12-CUDA-11.7.0
ml Python/3.9.6-bare
source venv
srun --distribution=plane=3 python3 -u MultiProcPerGPU_DPPMPI.py
