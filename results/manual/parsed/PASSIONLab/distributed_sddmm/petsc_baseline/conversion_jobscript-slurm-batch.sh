#!/bin/bash
#SBATCH --job-name=conversion_jobscript
#SBATCH --mail-user=vivek_bharadwaj@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=regular
#SBATCH --constraint=haswell

export OMP_NUM_THREADS='32'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=32
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
srun -n 1 python ConvertMtxToPetsc.py $SCRATCH/dist_sddmm/twitter7-permuted.mtx
