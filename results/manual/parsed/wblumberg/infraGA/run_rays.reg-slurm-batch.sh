#!/bin/bash
#SBATCH --job-name=rays
#SBATCH --account=s2094
#SBATCH --output=/discover/nobackup/wgblumbe/infraGA/rays.out
#SBATCH --error=/discover/nobackup/wgblumbe/infraGA/rays.err
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=allnccs
#SBATCH --constraint=hasw

source ./common.reg || exit 1
cd /discover/nobackup/wgblumbe/infraGA
which mpirun
mpirun -np 28 ./bin/infraga-accel-3d -prop examples/ToyAtmo.met incl_step=1.0 bounces=2 azimuth=-45.0 write_rays=true min_x=0 max_x=60 min_y=0 max_y=60 write_atmo=true 
