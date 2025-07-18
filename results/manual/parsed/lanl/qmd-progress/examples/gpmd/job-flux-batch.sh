#!/bin/bash
#FLUX: --job-name=spicy-caramel-6727
#FLUX: -n=40
#FLUX: --queue=ccs6
#FLUX: -t=604800
#FLUX: --urgency=16

export OMP_NUM_THREADS='40'
export KMP_STACKSIZE='3200M'

ulimit -s unlimited
module load gcc/5.4.0
module load openmpi/1.10.3-gcc_5.4.0
module load cmake
module load mkl
source /projects/opt/intel/parallel_studio_xe_2016/mkl/bin/mklvars.sh intel64
export OMP_NUM_THREADS=40
export KMP_STACKSIZE=3200M
./run.sh 
