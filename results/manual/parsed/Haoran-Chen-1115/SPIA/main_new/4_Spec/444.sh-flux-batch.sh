#!/bin/bash
#FLUX: --job-name=placid-house-8269
#FLUX: --queue=GPU
#FLUX: --urgency=15

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;Spec_main;quit" >> log_$NCL
