#!/bin/bash
#SBATCH --job-name=lmp_diffuse_2d
#SBATCH --output=lmp_diffuse_2d.%J.out
#SBATCH --error=lmp_diffuse_2d.%J.err
#SBATCH --nodes=5
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1024
#SBATCH --time=06:00:00

module load cce/10.0.3
module load craype/2.7.2
module load cray-mpich/8.0.15
module load cray-libsci/20.08.1.2
cd /home/users/msrinivasa/develop/lammps
srun build/lmp+pat -i examples/DIFFUSE/in.msd.2d
