#!/bin/bash
#FLUX: --job-name=frigid-fudge-3816
#FLUX: --queue=mic
#FLUX: -t=86400
#FLUX: --priority=16

setpkgs -a matlab
matlab -nodisplay -nosplash < matrix.m
