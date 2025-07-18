#!/bin/bash
#FLUX: --job-name=fcc_VAR_Th
#FLUX: --queue=shared
#FLUX: -t=1800
#FLUX: --urgency=16

module --force purge
ml load cpu slurm gcc openmpi
lammps="${HOME}/dc3/lammps/src/lmp_mpi"
potdir="${HOME}/dc3/potentials"
date
srun  ${lammps} -in in.lmp \
                -log data/logs/lammps_VAR_Th.log \
                -screen none \
                -var potdir ${potdir} \
                -var RANDOM ${RANDOM} \
                -var Th VAR_Th
date
