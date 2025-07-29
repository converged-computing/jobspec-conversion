#!/bin/bash
#FLUX: --job-name=2048_acoustics
#FLUX: -N=64
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PYTHONPATH='/project/k1069/lib/python2.7/site-packages:$PYTHONPATH'

echo job running on...
hostname
module load python/.pyclaw_64bits_493
export OMP_NUM_THREADS=1
export PYTHONPATH=/project/k1069/lib/python2.7/site-packages:$PYTHONPATH
srun --ntasks=2048 --cpus-per-task=1 --hint=nomultithread --ntasks-per-node=32 --ntasks-per-socket=16 --ntasks-per-core=1 --cpu_bind=cores python ../acoustics_3d_scaling.py -s strong -x 256 use_petsc=1
