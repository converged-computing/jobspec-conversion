#!/bin/bash
#FLUX: --job-name=IONS_LAMMPS
#FLUX: --queue=general
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'

module swap PrgEnv-intel PrgEnv-gnu
module load boost/gnu
module load gsl
module load lammps/gnu/7Aug19
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=16
time srun -n 1 -d 16 lmp_mpi < in.lammps
