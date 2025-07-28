#!/bin/bash
#FLUX: --job-name=lovely-puppy-0991
#FLUX: --queue=serial_requeue
#FLUX: -t=900
#FLUX: --urgency=16

module load matlab/R2018b-fasrc01
matlab -nojvm -batch 'try, run("./hello.m"), catch, exit(1), end, exit(0)' 
