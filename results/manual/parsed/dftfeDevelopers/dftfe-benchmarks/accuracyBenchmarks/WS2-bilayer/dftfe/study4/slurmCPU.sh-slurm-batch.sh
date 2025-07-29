#!/bin/bash
#SBATCH --job-name=WS2
#SBATCH --account=vikramg1
#SBATCH --mail-user=dsambit@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=4-04:00:00
#SBATCH --constraint=ntasks-per-node=36

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
mpirun -n 288 /scratch/vikramg_root/vikramg/dsambit/buildChebyOpt/release/real/dftfe parameterFile.prm > outputFeorder7Mesh1p6Atomballradius6p0Relaxation
