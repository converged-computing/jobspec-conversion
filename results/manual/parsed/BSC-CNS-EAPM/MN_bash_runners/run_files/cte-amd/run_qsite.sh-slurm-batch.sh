#!/bin/bash
#FLUX: --job-name=Qsite
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --urgency=16

export PATH='$PATH:/gpfs/projects/bsc72/Programs/schrodinger2024-1'
export SCHRODINGER='/gpfs/projects/bsc72/Programs/schrodinger2024-1'

export PATH=$PATH:/gpfs/projects/bsc72/Programs/schrodinger2024-1
export SCHRODINGER=/gpfs/projects/bsc72/Programs/schrodinger2024-1
$SCHRODINGER/qsite -PARALLEL 4 -WAIT e0_t74_st57_en-18.3_dis5.29_1.in
