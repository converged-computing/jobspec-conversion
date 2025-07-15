#!/bin/bash
#FLUX: --job-name=CAMP
#FLUX: -c=128
#FLUX: --queue=standard
#FLUX: -t=4800
#FLUX: --priority=16

export OMP_NUM_THREADS='128'
export OMP_PROC_BIND='true'

module load cray-python
source /work/ta094/ta094/wenqingpeng/pyenv-camp/bin/activate
export OMP_NUM_THREADS=128
export OMP_PROC_BIND=true
srun --hint=nomultithread --unbuffered ./camp config/example
