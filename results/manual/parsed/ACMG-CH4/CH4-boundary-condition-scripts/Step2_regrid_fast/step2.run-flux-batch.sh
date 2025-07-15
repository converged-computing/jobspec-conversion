#!/bin/bash
#FLUX: --job-name=pusheena-cat-9755
#FLUX: --priority=16

export OMP_NUM_THREADS='8'
export PYTHONPATH='/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts'

export OMP_NUM_THREADS=8
conda activate gcpy
source ~/envs/gcc_cmake.gfortran102_cannon.env
export PYTHONPATH="/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts"
module load R/4.1.0-fasrc01
srun -c $OMP_NUM_THREADS time -p ./read_daily.py >> step2feb22.log
exit 0
