#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=[intel18]

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
