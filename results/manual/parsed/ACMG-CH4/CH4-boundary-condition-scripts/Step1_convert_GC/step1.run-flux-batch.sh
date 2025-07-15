#!/bin/bash
#FLUX: --job-name=tart-fork-3045
#FLUX: --priority=16

export OMP_NUM_THREADS='8'
export PYTHONPATH='/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts'

export OMP_NUM_THREADS=8
source ~/envs/gcc_cmake.gfortran102_cannon.env
export PYTHONPATH="/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts"
srun -c $OMP_NUM_THREADS time -p ./template_archive.py >> step1.log
exit 0
