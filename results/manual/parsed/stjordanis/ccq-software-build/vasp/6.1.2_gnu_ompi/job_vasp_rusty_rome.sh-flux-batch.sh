#!/bin/bash
#FLUX: --job-name=vasp
#FLUX: --queue=gen
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm vasp/6.1.2_gnu_ompi/module-rome
mpirun vasp_std
