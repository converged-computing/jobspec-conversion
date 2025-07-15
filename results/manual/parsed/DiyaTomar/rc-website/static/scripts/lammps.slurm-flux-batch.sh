#!/bin/bash
#FLUX: --job-name=carnivorous-fork-5443
#FLUX: -N=2
#FLUX: --queue=parallel
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load intel lammps
srun lmp_iimpi -in run.in.npt
