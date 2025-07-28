#!/bin/bash
#FLUX: --job-name=expensive-pedo-1816
#FLUX: --queue=GPU36
#FLUX: --urgency=15

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;SPIA;quit" 2>&1 > log_$NCL
