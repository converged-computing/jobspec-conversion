#!/bin/bash
#FLUX: --job-name=c1l
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

module load matlab/R2017a
matlab -nodisplay < optimize_1ch_lin.m
