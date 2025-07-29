#!/bin/bash
#SBATCH --job-name=petsc_baseline
#SBATCH --mail-user=vivek_bharadwaj@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=256
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:30:00
#SBATCH --partition=regular
#SBATCH --constraint=knl

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load cray-petsc-64/3.13.3.0
module swap PrgEnv-intel PrgEnv-gnu
r=128
echo "Starting UK-2002 PetSC Benchmarks"
in_file=$SCRATCH/dist_sddmm/uk-2002-permuted.petsc
out_file=petsc_uk_strong.out
srun -N 4   -n 272   ./petsc_bench $in_file 10 $r $out_file
