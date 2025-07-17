#!/bin/bash
#FLUX: --job-name=carnivorous-noodle-5726
#FLUX: -n=4
#FLUX: --queue=shared
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export JULIA_NUM_THREADS='threads'

module load intel/19.0.5-fasrc01 openmpi/4.0.2-fasrc01 fftw/3.3.8-fasrc01 cmake/3.12.1-fasrc01 Anaconda3/2019.10 python/3.7.7-fasrc01
module list
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export JULIA_NUM_THREADS=threads
echo "running...."
/n/home03/calmiller/programs/julia /n/home03/calmiller/DSMC_Simulations/ParticleTracing/ParticleTracing.jl -z 0.035 -T 2.0 -n 100000 ./cell.510001.surfs ./DS2FF.500000.DAT
