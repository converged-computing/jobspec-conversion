#!/bin/bash
#FLUX: --job-name=vasp-openmpi-slurm
#FLUX: -n=48
#FLUX: --queue=all
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module purge
module use /software/spack_v17d2/spack/share/spack/modules/linux-rhel7-x86_64/
module load vasp/5.4.4-openmpi-intel
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NTASKS} vasp_std
