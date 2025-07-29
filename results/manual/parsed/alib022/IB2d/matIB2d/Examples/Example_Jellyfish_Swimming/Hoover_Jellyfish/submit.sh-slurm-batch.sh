#!/bin/bash
#FLUX: --job-name=matlab
#FLUX: --queue=nolimit
#FLUX: -t=864000
#FLUX: --urgency=16

echo "Starting @ "`date`
matlab -nodisplay < main2d.m > main2d.out
echo "Completed @ "`date`
