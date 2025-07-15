#!/bin/bash
#FLUX: --job-name=spicy-car-0565
#FLUX: --queue=mic
#FLUX: -t=86400
#FLUX: --urgency=16

setpkgs -a matlab
matlab -nodisplay -nosplash < matrix.m
