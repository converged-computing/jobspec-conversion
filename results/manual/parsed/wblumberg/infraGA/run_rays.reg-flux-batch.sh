#!/bin/bash
#FLUX: --job-name=rays
#FLUX: -n=28
#FLUX: -t=600
#FLUX: --urgency=16

source ./common.reg || exit 1
cd /discover/nobackup/wgblumbe/infraGA
which mpirun
mpirun -np 28 ./bin/infraga-accel-3d -prop examples/ToyAtmo.met incl_step=1.0 bounces=2 azimuth=-45.0 write_rays=true min_x=0 max_x=60 min_y=0 max_y=60 write_atmo=true 
