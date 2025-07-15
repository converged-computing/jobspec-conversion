#!/bin/bash
#FLUX: --job-name=loopy-chip-5613
#FLUX: --urgency=16

module purge                           # Unload all modules
module load gcc lammps                 # Load LAMMPS
srun lmp\
 -var x 8 -var y 4 -var z 8\
 -in lammps_gpu.in
