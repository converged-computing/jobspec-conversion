#!/bin/bash
#FLUX: --job-name=wobbly-peanut-8686
#FLUX: -n=32
#FLUX: -t=600
#FLUX: --urgency=16

~/julia-1.7.0/bin/julia generate_mesh.jl 
g++ openmp_version.cpp -fopenmp
./a.out 1 
./a.out 2 
./a.out 4 
./a.out 8 
./a.out 16 
./a.out 32 
~/julia-1.7.0/bin/julia result_figure.jl 
scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
