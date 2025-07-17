#!/bin/bash
#FLUX: --job-name=HT_QOptica_1e3
#FLUX: --queue=intel
#FLUX: -t=432000
#FLUX: --urgency=16

date
module load matlab/r2018a
matlab -nodisplay -nosplash <ssfres_normal_thermal_resonance_shift_trans_adapt_04_QingOptica_1e3.m> run.log
