#!/bin/bash
#FLUX: --job-name=ectd
#FLUX: -c=8
#FLUX: --queue=gpu_debug
#FLUX: --priority=16

export OMP_NUM_THREADS='8'

module load apps/gromacs-2020.2
export OMP_NUM_THREADS=8
srun -n 1 gmx_mpi grompp -p trappe -f npt -c ectd_w_10_4162 -o ectd_w_10_4162
srun -n 1 gmx_mpi mdrun -s -o -x -c -e -g -v -deffnm ectd_w_10_4162
srun -n 1 gmx_mpi grompp -p trappe -f nvt -c ectd_w_10_4162 -o ectd_w_10_4162
srun -n 1 gmx_mpi mdrun -s -o -x -c -e -g -v -deffnm ectd_w_10_4162
