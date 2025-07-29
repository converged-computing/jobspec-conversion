#!/bin/bash
#SBATCH --job-name=qe
#SBATCH --account=vikramg1
#SBATCH --mail-user=dsambit@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=18

export OMP_NUM_THREADS='2'

export OMP_NUM_THREADS=2
mpirun -n 54 pw.x -input mo4x.scf.in > mo4xEcut50.scf.out
