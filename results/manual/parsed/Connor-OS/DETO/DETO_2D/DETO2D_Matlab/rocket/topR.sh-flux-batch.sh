#!/bin/bash
#FLUX: --job-name=gassy-pastry-3785
#FLUX: -c=5
#FLUX: --urgency=16

export MCR_CACHE_ROOT='$TMPDIR'

module load MATLAB
matlab -nodisplay -nosplash < topR.m
export MCR_CACHE_ROOT=$TMPDIR
