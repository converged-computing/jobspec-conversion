#!/bin/bash
#FLUX: --job-name=job3-sehacker
#FLUX: -n=16
#FLUX: -t=345600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'

module purge  
module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3 gromacs/2021.2
export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK:-1}"
gmx mdrun -deffnm md_0_10
