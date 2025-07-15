#!/bin/bash
#FLUX: --job-name=fugly-gato-7127
#FLUX: -N=2
#FLUX: --queue=parallel
#FLUX: -t=259200
#FLUX: --priority=16

module purge
module load intel lammps
srun lmp_iimpi -in run.in.npt
