#!/bin/bash
#FLUX: --job-name=doopy-despacito-2720
#FLUX: --queue=GPU36
#FLUX: --urgency=16

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;SPIA;quit" 2>&1 > log_$NCL
