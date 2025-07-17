#!/bin/bash
#FLUX: --job-name=sticky-underoos-1264
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load goolf/11.2.0_4.1.4 gromacs
srun gmx_mpi <arguments>
