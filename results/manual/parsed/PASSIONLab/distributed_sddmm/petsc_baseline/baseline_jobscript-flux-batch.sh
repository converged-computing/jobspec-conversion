#!/bin/bash
#FLUX: --job-name=petsc_baseline
#FLUX: -N=256
#FLUX: --queue=regular
#FLUX: -t=16200
#FLUX: --urgency=16

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
