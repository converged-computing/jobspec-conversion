#!/bin/bash
#SBATCH --job-name=vasp
#SBATCH --account=GOV108008
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=1-00:30:00
#SBATCH --constraint=ntasks-per-node=32,ntasks-per-socket=16

export I_MPI_PMI_LIBRARY='/lib64/libpmi.so'

export I_MPI_PMI_LIBRARY=/lib64/libpmi.so
module purge
module load compiler/intel/2018
module load nvidia/cuda/10.0
VASP_EXE=/home/p00lcy01/VASP/icc_mkl/bin/vasp_std
OPTION="--cpu_bind=core"
srun ${OPTION} ${VASP_EXE}
echo "=== Wall time: $SECONDS secs."
