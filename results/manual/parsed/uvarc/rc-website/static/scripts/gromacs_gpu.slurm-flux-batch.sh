#!/bin/bash
#FLUX: --job-name=hairy-bits-6268
#FLUX: --priority=16

module purge
module load goolf/11.2.0_4.1.4 gromacs
srun gmx_mpi <arguments>
