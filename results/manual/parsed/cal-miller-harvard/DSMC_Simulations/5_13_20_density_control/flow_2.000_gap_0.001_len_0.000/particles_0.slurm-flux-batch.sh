#!/bin/bash
#FLUX: --job-name=doopy-parsnip-3045
#FLUX: --urgency=16

cd data
pwd
echo "running...."
julia /n/home03/calmiller/DSMC_Simulations/ParticleTracing/ParticleTracing.jl -z 0.035 -T 2.0 -n 100000 ./cell.510001.surfs ./DS2FF.500000.DAT --omega 0 --stats ./stats_omega_0.csv --exitstats ./exitstats_omega_0.csv
