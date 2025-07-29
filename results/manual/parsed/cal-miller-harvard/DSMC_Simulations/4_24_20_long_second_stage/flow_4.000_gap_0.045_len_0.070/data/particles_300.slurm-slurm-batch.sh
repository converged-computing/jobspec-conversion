#!/bin/bash
#SBATCH --output=particles_omega_300_job_%j.out
#SBATCH --error=particles_omega_300_job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=02:00:00
#SBATCH --partition=shared

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export JULIA_NUM_THREADS='threads'

module load intel/19.0.5-fasrc01 openmpi/4.0.2-fasrc01 fftw/3.3.8-fasrc01 cmake/3.12.1-fasrc01 Anaconda3/2019.10 python/3.7.7-fasrc01
module list
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export JULIA_NUM_THREADS=threads
echo "running...."
/n/home03/calmiller/programs/julia /n/home03/calmiller/DSMC_Simulations/ParticleTracing/ParticleTracing.jl -z 0.035 -T 2.0 -n 500000 ./cell.510001.surfs ./DS2FF.500000.DAT --omega 300 --stats ./stats_omega_300.csv --exitstats ./exitstats_omega_300.csv
