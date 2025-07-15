#!/bin/bash
#FLUX: --job-name=chunky-blackbean-7450
#FLUX: --priority=16

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
julia /n/home03/calmiller/DSMC_Simulations/ParticleTracing/ParticleTracing.jl -z 0.035 -T 2.0 -n 1000000 ./cell.surfs ./DS2FF.DAT --omega 0.00000 --pflip 0.10000 -m 3.00000 -M 57.00000 --sigma 1.30000E-18 --zmin 0.06509 --zmax 0.14609 --stats ./stats_omega_0.00000_M_57.0_zmax_0.14609_pflip_0.10000.csv --exitstats ./exitstats_omega_0.00000_M_57.0_zmax_0.14609_pflip_0.10000.csv --saveall 0
