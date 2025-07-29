#!/bin/bash
#FLUX: --job-name=lammps_test
#FLUX: -N=2
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='/home/$USER/software_slurm/lammps-23Jun2022/build-kokkos-gpu-omp:$PATH'

module load openmpi/4.1.5
export PATH=/home/$USER/software_slurm/lammps-23Jun2022/build-kokkos-gpu-omp:$PATH
cd $SLURM_SUBMIT_DIR
srun lmp -sf gpu -pk gpu 2 -in in.lj.txt
