#!/bin/bash
#FLUX: --job-name=MD
#FLUX: -c=7
#FLUX: --queue=htc
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load gpu/gromacs/2020.1
gmx mdrun -deffnm md -v -update gpu
