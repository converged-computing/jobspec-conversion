#!/bin/bash
#SBATCH --job-name=WS2Spin
#SBATCH --account=vikramg1
#SBATCH --mail-user=dsambit@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=36

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
mpirun -n 144 /scratch/vikramg_root/vikramg/dsambit/buildTest/release/real/dftfe parameterFile.prm > outputMesh2
