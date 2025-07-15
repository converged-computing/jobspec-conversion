#!/bin/bash
#FLUX: --job-name=eccentric-motorcycle-5832
#FLUX: --urgency=16

export R_LIBS_USER='/n/home11/skbwu/apps/R_422 # tell R where to look for locally installed packages'

module load cmake/3.25.2-fasrc01
module load gcc/12.2.0-fasrc01
module load R/4.2.2-fasrc01 # load in the R module
export R_LIBS_USER=/n/home11/skbwu/apps/R_422 # tell R where to look for locally installed packages
for seed in {0..9}; do
    # call in our scripts - there should only be three settings
    Rscript lorenz_main_v4_RF.R $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} "$seed" # directly run the script!
    # make sure the script finishes running before we launch the next one
    wait
done
