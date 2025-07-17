#!/bin/bash
#FLUX: --job-name=MyMATLABJob
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

t0=$(date +%s)
module load matlab/R2021a
matlab-threaded -nodesktop -nosplash -r "myfunction($SLURM_ARRAY_TASK_ID), exit"
t1=$(date +%s)
dt=$(echo "$t1 - $t0" | bc)
printf "Total execution time (s): %08.1f\n" $dt
