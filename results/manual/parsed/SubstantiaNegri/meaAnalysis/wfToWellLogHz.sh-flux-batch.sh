#!/bin/bash
#FLUX: --job-name=gloopy-banana-9854
#FLUX: -n=4
#FLUX: --queue=priority
#FLUX: -t=900
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$1" != "" ]; then
    echo "Recording Duration provided as ${1} seconds"
else
    echo "Error: Need to provide Recording Duration as integer in seconds"
fi
srun ~/scripts/R-3.4.1/wfToWellLogHz.R $1
