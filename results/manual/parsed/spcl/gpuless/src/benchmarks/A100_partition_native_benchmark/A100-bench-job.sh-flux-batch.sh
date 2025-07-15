#!/bin/bash
#FLUX: --job-name="gpuless"
#FLUX: --queue=amda100
#FLUX: -t=4800
#FLUX: --priority=16

module load cuda
module load python
source ~/testenv/bin/activate
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/apps/ault/spack/opt/spack/linux-centos8-zen/gcc-8.4.1/cuda-11.8.0-fjdnxm6yggxxp75sb62xrxxmeg4s24ml/lib64 \
srun python ./A100-bench.py
