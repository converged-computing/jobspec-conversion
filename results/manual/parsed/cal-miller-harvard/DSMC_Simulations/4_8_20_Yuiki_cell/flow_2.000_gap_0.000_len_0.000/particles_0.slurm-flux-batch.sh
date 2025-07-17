#!/bin/bash
#FLUX: --job-name=milky-leopard-5700
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=480
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export JULIA_NUM_THREADS='$SLURM_CPUS_ON_NODE'

module load intel/19.0.5-fasrc01 openmpi/4.0.2-fasrc01 fftw/3.3.8-fasrc01 cmake/3.12.1-fasrc01 Anaconda3/2019.10 python/3.7.7-fasrc01
module list
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export JULIA_NUM_THREADS=$SLURM_CPUS_ON_NODE
cd data
pwd
echo "running...."
/n/home03/calmiller/programs/julia /n/home03/calmiller/DSMC_Simulations/4_8_20_Yuiki_cell/ParticleTracingYuiki.jl -z 0.049 -T 4.0 -n 200000 ./cell.510001.surfs ./DS2FF.500000.DAT --omega 0 --stats ./stats_omega_0.csv --exitstats ./exitstats_omega_0.csv
