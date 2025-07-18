#!/bin/bash
#FLUX: --job-name=gassy-destiny-6913
#FLUX: -c=8
#FLUX: --queue=huce_intel
#FLUX: -t=1440
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'
export PYTHONPATH='/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts'

export OMP_NUM_THREADS=8
conda activate gcpy
source ~/envs/gcc_cmake.gfortran102_cannon.env
export PYTHONPATH="/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts"
module load R/4.1.0-fasrc01
srun -c $OMP_NUM_THREADS time -p ./read_daily.py >> step2feb22.log
exit 0
