#!/bin/bash
#SBATCH --job-name=__job-name
#SBATCH --output=std.out
#SBATCH --error=std.err
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=24,intel

export OMP_NUM_THREADS='1'

module load lammps/29Sep2021/openmpi-4.0.3_intel2020
lmp_ibex="/sw/csi/lammps/29Sep2021/openmpi-4.0.3_intel2020/install/bin/lmp_ibex"
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NPROCS} ${lmp_ibex} -in INCAR.lmp
