#!/bin/bash
#FLUX: --job-name=calc_pi
#FLUX: -N=64
#FLUX: -t=900
#FLUX: --urgency=16

cd ~/Documents/project-2-pi-by-mpi-seven-c-s/Nick_Work            ### change to the directory where your code is located
num_darts=(1000 1000000 1000000000)
for cpus in 1 2 4 8 16 32 64
do 
    output=$(mpiexec -n $cpus ./pi ${num_darts[$SLURM_ARRAY_TASK_ID]})
    echo -e "${output},${cpus},${num_darts[$SLURM_ARRAY_TASK_ID]} "
done
