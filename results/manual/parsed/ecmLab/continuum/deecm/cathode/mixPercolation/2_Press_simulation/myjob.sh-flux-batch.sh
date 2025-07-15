#!/bin/bash
#FLUX: --job-name=NMC_LPS
#FLUX: --queue=tier3
#FLUX: -t=1800
#FLUX: --priority=16

spack load lammps@2023208 /cuxhkce
srun lmp -log none -in mr.in
