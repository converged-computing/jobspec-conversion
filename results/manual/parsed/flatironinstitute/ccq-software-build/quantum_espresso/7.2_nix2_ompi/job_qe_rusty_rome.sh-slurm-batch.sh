#!/bin/bash
#SBATCH --job-name=qe-test-rome
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --partition=ccq
#SBATCH --constraint=ntasks-per-node=128,rome

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm quantum_espresso/7.2_nix2_gnu_ompi
mpirun pw.x < si.scf.in > si.scf.out
