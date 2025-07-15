#!/bin/bash
#FLUX: --job-name=delicious-bits-9887
#FLUX: --priority=16

module load matlab/R2018b-fasrc01
matlab -nojvm -batch 'try, run("./hello.m"), catch, exit(1), end, exit(0)' 
