#!/bin/bash
#FLUX: --job-name=frigid-lizard-4375
#FLUX: --urgency=16

module purge
module load goolf/11.2.0_4.1.4 gromacs
srun gmx_mpi <arguments>
