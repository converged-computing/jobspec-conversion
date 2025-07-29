#!/bin/bash
#FLUX --job-name=dinosaur-snack-0561
#FLUX --queue=gpu
#FLUX -t=259200
#FLUX --urgency=16

module purge
module load goolf lammps/2Aug2023
srun lmp -in run.in.npt
