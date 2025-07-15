#!/bin/bash
#FLUX: --job-name=val1_hctsa
#FLUX: -c=36
#FLUX: -t=259200
#FLUX: --priority=16

module load matlab/r2019b
time matlab -nodisplay -nodesktop -r "add_toolbox; main_hctsa_2_compute('HCTSA_validate1.mat'); exit"
