#!/bin/bash
#FLUX: --job-name=quirky-taco-4159
#FLUX: --queue=GPU
#FLUX: --urgency=16

module load matlab/R2022a 
NCL=$1
matlab -nodesktop -nosplash -nodisplay -r "NCL=$NCL;Spec_main;quit" >> log_$NCL
