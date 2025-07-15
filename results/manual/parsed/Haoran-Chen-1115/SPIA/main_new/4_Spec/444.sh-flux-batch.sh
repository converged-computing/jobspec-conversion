#!/bin/bash
#FLUX: --job-name=stanky-cat-1505
#FLUX: --queue=GPU
#FLUX: --priority=16

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;Spec_main;quit" >> log_$NCL
