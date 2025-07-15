#!/bin/bash
#FLUX: --job-name=reclusive-caramel-8887
#FLUX: --priority=16

t0=$(date +%s)
module load matlab/R2021a
matlab-threaded -nodesktop -nosplash -r "myfunction($SLURM_ARRAY_TASK_ID), exit"
t1=$(date +%s)
dt=$(echo "$t1 - $t0" | bc)
printf "Total execution time (s): %08.1f\n" $dt
