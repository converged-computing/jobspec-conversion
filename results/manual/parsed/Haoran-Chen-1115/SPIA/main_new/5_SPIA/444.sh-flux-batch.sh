#!/bin/bash
#FLUX: --job-name=astute-poo-1110
#FLUX: --queue=GPU36
#FLUX: --priority=16

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;SPIA;quit" 2>&1 > log_$NCL
