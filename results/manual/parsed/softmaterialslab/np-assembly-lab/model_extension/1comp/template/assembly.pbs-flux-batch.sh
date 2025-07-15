#!/bin/bash
#FLUX: --job-name=USERVLP_USERSALTCONC
#FLUX: --queue=general
#FLUX: -t=10800
#FLUX: --priority=16

module load lammps/29Oct20
cd      $SLURM_SUBMIT_DIR
time srun -n 48 lmp_mpi < in.1comp.template
