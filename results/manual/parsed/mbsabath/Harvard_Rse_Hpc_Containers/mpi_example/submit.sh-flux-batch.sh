#!/bin/bash
#FLUX: --job-name=mpi_example
#FLUX: -N=2
#FLUX: --queue=shared
#FLUX: -t=300
#FLUX: --priority=16

module load gcc/13.2.0-fasrc01 openmpi/4.1.5-fasrc03
srun -n $SLURM_NTASKS --mpi=pmix singularity run mpi_example.sif
