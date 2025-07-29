#!/bin/bash
#SBATCH --job-name=lammps_voro
#SBATCH --output=/blues/gpfs/home/tshu/project/bebop/MPI_in_MPI/bebop-psm2/Example-LAMMPS/swift-all/experiment/output.txt
#SBATCH --error=/blues/gpfs/home/tshu/project/bebop/MPI_in_MPI/bebop-psm2/Example-LAMMPS/swift-all/experiment/error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --partition=bdwall
#SBATCH --constraint=ntasks-per-node=36
#SBATCH --chdir=/blues/gpfs/home/tshu/project/bebop/MPI_in_MPI/bebop-psm2/Example-LAMMPS/swift-all/experiment

export I_MPI_FABRICS='shm:tmi'

export I_MPI_FABRICS=shm:tmi
/usr/bin/time -v -o time_lmp_mpi.txt timeout 600 mpiexec -n 32 -ppn 8 -hosts bdw-0150,bdw-0151,bdw-0157,bdw-0158 /blues/gpfs/home/tshu/project/bebop/MPI_in_MPI/bebop-psm2/Example-LAMMPS/swift-all/lmp_mpi -i in.quench > output_lmp_mpi.txt 2>&1
