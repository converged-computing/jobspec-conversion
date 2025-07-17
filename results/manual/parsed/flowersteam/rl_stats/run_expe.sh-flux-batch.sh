#!/bin/bash
#FLUX: --job-name=blank-eagle-1197
#FLUX: --queue=longq
#FLUX: -t=54000
#FLUX: --urgency=16

export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;'

rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP run_experiment.py --study equal_dist_equal_var &
$EXP_INTERP run_experiment.py --study equal_dist_unequal_var &
$EXP_INTERP run_experiment.py --study unequal_dist_equal_var &
$EXP_INTERP run_experiment.py --study unequal_dist_unequal_var_1 &
$EXP_INTERP run_experiment.py --study unequal_dist_unequal_var_2 &
wait
