#!/bin/bash
#FLUX: --job-name=psycho-house-6054
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module purge
module load goolf lammps/2Aug2023
srun lmp -in run.in.npt
