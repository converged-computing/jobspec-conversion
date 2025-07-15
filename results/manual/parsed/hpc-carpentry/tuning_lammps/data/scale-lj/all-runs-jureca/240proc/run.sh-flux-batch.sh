#!/bin/bash
#FLUX: --job-name=ornery-egg-8595
#FLUX: -N=5
#FLUX: --queue=devel
#FLUX: -t=900
#FLUX: --priority=16

module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/9Jan2020-cuda
srun lmp < in.lj|tee out.lj
