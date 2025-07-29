#!/bin/bash
#SBATCH --job-name=r0_9_l_k
#SBATCH --output=r0_9_l_k-%A_%a.out
#SBATCH --error=r0_9_l_k-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=20gb
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-14

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export MKL_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export HOME='~'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export MKL_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export HOME=~
module load compiler/intel/19.1.2
module load mpi/impi
module load devel/valgrind
module load numlib/mkl/2020.2
srun $(ws_find conda)/conda/envs/quimbPet/bin/python ~/Anderson-localization/mpsPhonons.py ${SLURM_ARRAY_TASK_ID} ${SLURM_ARRAY_TASK_COUNT}
