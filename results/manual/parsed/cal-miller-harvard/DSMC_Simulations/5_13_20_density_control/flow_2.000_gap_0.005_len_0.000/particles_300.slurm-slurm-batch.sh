#!/bin/bash
#SBATCH --output=particles_omega_300_job_%j.out
#SBATCH --error=particles_omega_300_job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=00:08:00
#SBATCH --partition=shared

cd data
pwd
echo "running...."
julia /n/home03/calmiller/DSMC_Simulations/ParticleTracing/ParticleTracing.jl -z 0.035 -T 2.0 -n 100000 ./cell.510001.surfs ./DS2FF.500000.DAT --omega 300 --stats ./stats_omega_300.csv --exitstats ./exitstats_omega_300.csv
