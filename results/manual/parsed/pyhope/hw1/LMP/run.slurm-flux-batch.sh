#!/bin/bash
#FLUX: --job-name=lammps
#FLUX: -t=3540
#FLUX: --urgency=16

module purge
module load anaconda3/2021.5
conda activate deepmd
lmp -in in.lammps
