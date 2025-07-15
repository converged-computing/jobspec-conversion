#!/bin/bash
#FLUX: --job-name=lmp_bench
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load lammps/8Feb2023-gcc8-impi-cuda118
export OMP_NUM_THREADS=1
PARAMS="--ntasks=10 --hint=nomultithread --cpus-per-task=1"
srun ${PARAMS} lmp -pk gpu 1 -sf gpu -in in.ethanol -l log.out_${SLURM_TASKS_PER_NODE}
