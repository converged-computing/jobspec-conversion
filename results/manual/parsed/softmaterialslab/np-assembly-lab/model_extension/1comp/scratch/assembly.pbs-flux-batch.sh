#!/bin/bash
#FLUX: --job-name=EEE2c100_12cores
#FLUX: --queue=general
#FLUX: -t=7200
#FLUX: --priority=16

module load lammps/29Oct20
cd      $SLURM_SUBMIT_DIR
time srun -n 12 lmp_mpi < in.lammps.template
