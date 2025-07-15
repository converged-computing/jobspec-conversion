#!/bin/bash
#FLUX: --job-name=E2
#FLUX: --queue=general
#FLUX: -t=7200
#FLUX: --priority=16

module swap PrgEnv-intel PrgEnv-gnu
module load lammps/gnu
cd      $SLURM_SUBMIT_DIR
time srun -n 48 lmp_mpi < in.lammps.template
