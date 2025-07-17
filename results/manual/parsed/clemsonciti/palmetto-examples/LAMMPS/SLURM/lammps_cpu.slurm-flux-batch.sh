#!/bin/bash
#FLUX: --job-name=lammps_test
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='/home/$USER/software_slurm/lammps-23Jun2022/build-openmpi-omp:$PATH'

module load openmpi/4.1.5
export PATH=/home/$USER/software_slurm/lammps-23Jun2022/build-openmpi-omp:$PATH
cd $SLURM_SUBMIT_DIR
srun lmp -sf omp -pk omp 8 -in in.lj.txt
