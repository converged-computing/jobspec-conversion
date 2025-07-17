#!/bin/bash
#FLUX: --job-name=butterscotch-diablo-8513
#FLUX: -c=5
#FLUX: -t=300
#FLUX: --urgency=16

export MCR_CACHE_ROOT='$TMPDIR'

module load MATLAB
matlab -nodisplay -nosplash < topR.m
export MCR_CACHE_ROOT=$TMPDIR
