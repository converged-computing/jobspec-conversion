#!/bin/bash
#FLUX: --job-name=expressive-cupcake-6910
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=240
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export JULIA_NUM_THREADS='$SLURM_CPUS_ON_NODE'

echo "loading things..."
module load intel/19.0.5-fasrc01 openmpi/4.0.2-fasrc01 fftw/3.3.8-fasrc01 cmake/3.12.1-fasrc01 Anaconda3/2019.10 python/3.7.7-fasrc01
module list
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export JULIA_NUM_THREADS=$SLURM_CPUS_ON_NODE
echo "running...."
mpirun ~/programs/sparta/spa -kokkos off < in.cell
sbatch particles_0.slurm
