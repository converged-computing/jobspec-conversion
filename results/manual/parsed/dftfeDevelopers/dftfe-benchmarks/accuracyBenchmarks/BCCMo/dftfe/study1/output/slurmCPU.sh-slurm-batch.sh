#!/bin/bash
#SBATCH --job-name=mo4x
#SBATCH --account=vikramg1
#SBATCH --mail-user=dsambit@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=36

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
mpirun -n 72 /scratch/vikramg_root/vikramg/dsambit/buildnew/release/real/dftfe parameterFileCPU.prm > outputFEOrder7Meshsize2p0
