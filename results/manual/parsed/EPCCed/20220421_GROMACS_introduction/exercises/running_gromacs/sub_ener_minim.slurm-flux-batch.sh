#!/bin/bash
#FLUX: --job-name=lovable-ricecake-6043
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gromacs
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
gmx mdrun -ntomp ${SLURM_CPUS_PER_TASK} -v -s ener_minim.tpr
