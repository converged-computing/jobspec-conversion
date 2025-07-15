#!/bin/bash
#FLUX: --job-name=spicy-citrus-4878
#FLUX: -t=7200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
~/soft/lammps/lammps-3Mar20/src/lmp_mpi -in in.lmp > log
