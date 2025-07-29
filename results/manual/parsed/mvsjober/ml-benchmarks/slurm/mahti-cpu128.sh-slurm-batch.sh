#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=logs/slurm-%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=00:01:00
#SBATCH --partition=test

export OMP_NUM_THREADS='128'
export MKL_NUM_THREADS='128'
export OMP_SCHEDULE='STATIC'
export OMP_PROC_BIND='CLOSE'
export GOMP_CPU_AFFINITY='0-127'

export OMP_NUM_THREADS=128
export MKL_NUM_THREADS=128
export OMP_SCHEDULE=STATIC
export OMP_PROC_BIND=CLOSE
export GOMP_CPU_AFFINITY="0-127"
cd $SLURM_SUBMIT_DIR
source slurm/common.sh
