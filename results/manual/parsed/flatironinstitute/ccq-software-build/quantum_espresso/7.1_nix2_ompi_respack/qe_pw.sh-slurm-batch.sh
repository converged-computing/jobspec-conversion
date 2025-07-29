#!/bin/bash
#SBATCH --job-name=ortho-GX
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=128,rome

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module load slurm
module load quantum_espresso/7.1_nix2_gnu_ompi_respack
mpirun pw.x -pd .true. -nk 8 < lno.bnd.in > lno.bnd.out 
mpirun -n 32 unfold.x -pd .true. < lno.unfold.in > lno.unfold.out
