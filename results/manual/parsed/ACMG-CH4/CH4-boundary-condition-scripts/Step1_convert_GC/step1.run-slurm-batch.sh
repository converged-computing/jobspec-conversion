#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=15000
#SBATCH --time=1-00:20:00
#SBATCH --partition=huce_intel

export OMP_NUM_THREADS='8'
export PYTHONPATH='/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts'

export OMP_NUM_THREADS=8
source ~/envs/gcc_cmake.gfortran102_cannon.env
export PYTHONPATH="/n/holyscratch01/jacob_lab/lestrada/IMI/CH4-boundary-condition-scripts"
srun -c $OMP_NUM_THREADS time -p ./template_archive.py >> step1.log
exit 0
