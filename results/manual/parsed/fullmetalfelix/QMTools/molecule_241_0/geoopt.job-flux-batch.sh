#!/bin/bash
#FLUX: --job-name=outstanding-leopard-8081
#FLUX: -c=10
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export PSI_SCRATCH='/tmp/'

export OMP_PROC_BIND=true
export PSI_SCRATCH=/tmp/
module load anaconda3
module load iomklc/triton-2017a
module load cmake/3.12.1
srun python geoopt.py
