#!/bin/bash
#FLUX: --job-name=crusty-car-1968
#FLUX: -c=6
#FLUX: --queue=gpu-common
#FLUX: --urgency=16

/opt/apps/matlabR2016a/bin/matlab -nojvm -nodisplay -singleCompThread -r mycode.m > file.out
