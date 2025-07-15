#!/bin/bash
#FLUX: --job-name=conspicuous-rabbit-3378
#FLUX: -N=2
#FLUX: --queue=parallel
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load goolf lammps/2Aug2023-cpu
srun lmp -in run.in.npt
