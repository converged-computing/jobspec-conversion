#!/bin/bash
#FLUX: --job-name=smd
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=9
#FLUX: --urgency=16

spack load openmpi@4.1.6
module load openmpi
particle_files=("../particle_files/particles_675" "../particle_files/particles_1250" "../particle_files/particles_2500" "../particle_files/particles_5000" "../particle_files/particles_10000" "../particle_files/particles_25000" "../particle_files/particles_50000" "../particle_files/particles_100000")
particle_sizes=(675 1250 2500 5000 10000 25000 50000 100000)
executable="particle_simulation"
mpic++ -fopenmp -std=c++11 -o $executable smd.cpp
for i in "${!particle_files[@]}"; do
    particle_file="${particle_files[$i]}"
    particle_size="${particle_sizes[$i]}"
    echo "Running simulation for ${particle_file} (${particle_size} particles)"
    srun ./$executable $particle_size $particle_file
done
