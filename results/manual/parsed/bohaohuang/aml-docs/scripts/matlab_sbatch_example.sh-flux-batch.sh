#!/bin/bash
#FLUX: --job-name=fat-car-0902
#FLUX: --priority=16

/opt/apps/matlabR2016a/bin/matlab -nojvm -nodisplay -singleCompThread -r mycode.m > file.out
