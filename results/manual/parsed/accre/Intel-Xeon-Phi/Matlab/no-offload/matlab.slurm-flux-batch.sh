#!/bin/bash
#FLUX --job-name=fat-soup-8339
#FLUX --queue=mic
#FLUX -t=86400
#FLUX --urgency=16

setpkgs -a matlab
matlab -nodisplay -nosplash < matrix.m
