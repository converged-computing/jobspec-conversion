#!/bin/bash
#FLUX: --job-name=blue-despacito-0975
#FLUX: --queue=GPU
#FLUX: --urgency=15

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;Spec_main;quit" >> log_$NCL
