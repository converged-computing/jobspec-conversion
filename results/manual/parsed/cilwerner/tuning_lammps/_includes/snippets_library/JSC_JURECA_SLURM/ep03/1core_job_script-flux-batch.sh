#!/bin/bash
#FLUX: --job-name=fugly-hobbit-2720
#FLUX: --queue=batch
#FLUX: -t=300
#FLUX: --priority=16

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/9Jan2020-cuda
srun lmp < in.lj > out.lj
