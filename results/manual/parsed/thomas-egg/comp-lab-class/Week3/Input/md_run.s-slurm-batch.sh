#!/bin/bash
#FLUX: --job-name=md_run
#FLUX: -c=12
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
cd /home/tje3676/chem-class-2023/comp-lab-class/Week3/Data
gmx_mpi mdrun -deffnm md_0_1
