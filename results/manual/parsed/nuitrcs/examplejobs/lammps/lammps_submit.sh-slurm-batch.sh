#!/bin/bash
#SBATCH --job-name=lammps_openmpi
#SBATCH --account=pXXXXX
#SBATCH --output=outlog_lammps_openmpi_intel
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3G
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=4,[quest8|quest9|quest10|quest11]

module purge
module load lammps/20200303-openmpi-4.0.5-intel-19.0.5.281
mpirun -np ${SLURM_NTASKS} lmp -in in.lj
