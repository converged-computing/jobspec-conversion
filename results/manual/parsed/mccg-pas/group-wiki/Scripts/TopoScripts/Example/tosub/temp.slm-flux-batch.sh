#!/bin/bash
#FLUX --job-name=pusheena-leader-3455
#FLUX -n=32
#FLUX -t=172800
#FLUX --urgency=16

module load lammps
srun --export=all -n 32 lmp_dam.openmpi -in TEAP.in > TEAP.out
