#!/bin/bash
#FLUX: --job-name=lovely-hobbit-1278
#FLUX: -n=32
#FLUX: -t=172800
#FLUX: --priority=16

module load lammps
srun --export=all -n 32 lmp_dam.openmpi -in TEAP.in > TEAP.out
