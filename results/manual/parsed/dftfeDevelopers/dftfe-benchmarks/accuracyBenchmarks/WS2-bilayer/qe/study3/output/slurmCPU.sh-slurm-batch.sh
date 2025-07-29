#!/bin/bash
#SBATCH --job-name=qe
#SBATCH --account=vikramg1
#SBATCH --mail-user=dsambit@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=36

export OMP_NUM_THREADS='2'

export OMP_NUM_THREADS=2
mpirun -n 108 pw.x -npool 1 -input WS2Ecut50.scf.in > WS2Ecut50.scf.out
