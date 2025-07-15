#!/bin/bash
#FLUX: --job-name=red-butter-9405
#FLUX: --urgency=16

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
srun -n 4 gmx_mpi mdrun -deffnm md -cpi md -multidir rep1 rep2 rep3 rep4 -ntomp $((SLURM_JOB_CPUS_PER_NODE/4)) -maxh 23
