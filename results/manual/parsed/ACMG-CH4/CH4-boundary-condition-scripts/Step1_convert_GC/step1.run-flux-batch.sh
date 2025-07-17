#!/bin/bash
#FLUX: --job-name=tart-mango-2923
#FLUX: -c=8
#FLUX: --queue=huce_intel
#FLUX: -t=87600
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'
export PYTHONPATH='/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts'

export OMP_NUM_THREADS=8
source ~/envs/gcc_cmake.gfortran102_cannon.env
export PYTHONPATH="/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts"
srun -c $OMP_NUM_THREADS time -p ./template_archive.py >> step1.log
exit 0
