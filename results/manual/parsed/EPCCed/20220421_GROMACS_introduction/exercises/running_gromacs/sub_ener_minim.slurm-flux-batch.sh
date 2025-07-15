#!/bin/bash
#FLUX: --job-name=ornery-leopard-7181
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gromacs
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
gmx mdrun -ntomp ${SLURM_CPUS_PER_TASK} -v -s ener_minim.tpr
