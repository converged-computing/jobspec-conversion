#!/bin/bash
#FLUX: --job-name=bricky-salad-1447
#FLUX: --urgency=16

/opt/apps/matlabR2016a/bin/matlab -nojvm -nodisplay -singleCompThread -r mycode.m > file.out
