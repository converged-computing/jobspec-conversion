#!/bin/bash
#SBATCH --job-name=lammps_test
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=2

export PATH='/home/$USER/software_slurm/lammps-23Jun2022/build-kokkos-gpu-omp:$PATH'

module load openmpi/4.1.5
export PATH=/home/$USER/software_slurm/lammps-23Jun2022/build-kokkos-gpu-omp:$PATH
cd $SLURM_SUBMIT_DIR
srun lmp -sf gpu -pk gpu 2 -in in.lj.txt
