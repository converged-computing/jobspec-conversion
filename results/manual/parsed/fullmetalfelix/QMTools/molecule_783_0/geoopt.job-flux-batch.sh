#!/bin/bash
#FLUX: --job-name=go_19
#FLUX: -c=10
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export PSI_SCRATCH='/tmp/'

export OMP_PROC_BIND=true
export PSI_SCRATCH=/tmp/
source ~/programs/psi4env/bin/activate 
module load iomklc/triton-2017a
module load cmake/3.12.1
srun python geoopt.py
