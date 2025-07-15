#!/bin/bash
#FLUX: --job-name=calculate_pi
#FLUX: -n=10
#FLUX: --priority=16

cd /home/pi/pi_cluster/mpi_pi_demo
start_time=`date +%s`
mpirun python3 mpi_numpi.py $1
end_time=`date +%s`
echo " Elapsed time $[$end_time-$start_time] seconds"
