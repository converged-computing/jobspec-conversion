#!/bin/bash
#FLUX --job-name=expensive-staircase-8421
#FLUX --queue=devel
#FLUX -t=900
#FLUX --urgency=16

module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/9Jan2020-cuda
srun lmp < in.chain|tee out.chain
