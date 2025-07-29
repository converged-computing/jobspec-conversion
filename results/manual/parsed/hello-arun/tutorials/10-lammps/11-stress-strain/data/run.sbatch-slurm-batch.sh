#!/bin/bash
#SBATCH --output=std.out
#SBATCH --error=std.err
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=24,intel

export OMP_NUM_THREADS='1'

module load openmpi/4.0.3
module load gcc/11.1.0
lmp_ibex="/ibex/scratch/jangira/lammps/sw/lammps-16Feb2016/openmpi/4.0.3/gcc/11.1.0/src/lmp_mpi"
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NPROCS} ${lmp_ibex} -in INCAR.lmp
