#!/bin/bash
#FLUX: --job-name=astute-pedo-7634
#FLUX: -c=5
#FLUX: --priority=16

export MCR_CACHE_ROOT='$TMPDIR'

module load MATLAB
matlab -nodisplay -nosplash < topR.m
export MCR_CACHE_ROOT=$TMPDIR
