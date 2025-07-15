#!/bin/bash
#FLUX: --job-name=chocolate-underoos-7299
#FLUX: -c=9
#FLUX: --queue=s.phys
#FLUX: -t=14400
#FLUX: --urgency=16

module load intel/19.1.3
module load impi/2019.9
module load gromacs/2019.6
sys=$1
srun gmx mdrun -v -deffnm $sys"_npt"
