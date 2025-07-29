#!/bin/bash
#SBATCH --account=research
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=4-00:00:00
#SBATCH --qos=medium

export LD_LIBRARY_PATH='/opt/lammps-7Aug19_nnp_plumed/lib/nnp/lib'

module load openmpi/4.0.0
export LD_LIBRARY_PATH=/opt/lammps-7Aug19_nnp_plumed/lib/nnp/lib
mpirun -np 10 /opt/lammps-7Aug19_nnp_plumed/src/lmp_mpi < in.lmp
echo "completed 1"
