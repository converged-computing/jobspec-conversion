#!/bin/bash
#SBATCH --job-name=melt
#SBATCH --output=melt.stdout
#SBATCH --error=melt.stderr
#SBATCH --mail-user=UCID@njit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --constraint=ntasks-per-node=8

module load singularity gnu8 openmpi3
rm -rf out
mkdir out/
mpirun -np ${SLURM_NTASKS} singularity exec /opt/site/singularity-apps/lammps/20200505/lammps-20200505-centos7-python3.6.9.sif lammps -i melt.in
