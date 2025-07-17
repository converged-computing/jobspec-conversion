#!/bin/bash
#FLUX: --job-name=lammps_test
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

module load aocc lammps
cd $SLURM_SUBMIT_DIR
srun lmp -sf omp -pk omp 8 -in in.lj.txt
