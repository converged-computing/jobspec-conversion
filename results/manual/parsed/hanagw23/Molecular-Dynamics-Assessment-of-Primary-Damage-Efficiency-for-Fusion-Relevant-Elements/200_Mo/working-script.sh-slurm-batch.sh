#!/bin/bash
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=3
#SBATCH --ntasks=96
#SBATCH --cpus-per-task=1
#SBATCH --time=2-23:00:00
#SBATCH --constraint=ntasks-per-node=32

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo "Lammps version used = 20220623      https://github.com/lammps/lammps/archive/patch_23Jun2022.tar.gz"
echo "Openmpi version used = 4.1.4     https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.4.tar.bz2"
. /usr/share/spack/root/share/spack/setup-env.sh
spack load lammps@20220623
spack load openmpi@4.1.4
mpirun lmp -i in.Mo_cascade
