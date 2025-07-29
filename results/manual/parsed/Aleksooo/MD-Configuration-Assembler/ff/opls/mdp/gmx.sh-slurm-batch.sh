#!/bin/bash
#SBATCH --job-name=ectd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=1
#SBATCH --partition=gpu_debug

export OMP_NUM_THREADS='8'

module load apps/gromacs-2020.2
export OMP_NUM_THREADS=8
srun -n 1 gmx_mpi grompp -p trappe -f npt -c ectd_w_10_4162 -o ectd_w_10_4162
srun -n 1 gmx_mpi mdrun -s -o -x -c -e -g -v -deffnm ectd_w_10_4162
srun -n 1 gmx_mpi grompp -p trappe -f nvt -c ectd_w_10_4162 -o ectd_w_10_4162
srun -n 1 gmx_mpi mdrun -s -o -x -c -e -g -v -deffnm ectd_w_10_4162
