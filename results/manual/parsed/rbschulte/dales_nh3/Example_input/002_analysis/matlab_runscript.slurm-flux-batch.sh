#!/bin/bash
#FLUX: --job-name=phat-bits-6256
#FLUX: --urgency=16

module load 2021
module load MATLAB/2021a-upd3
echo "mcc -m DALES_ProcessOutput002.m" | matlab -nodisplay
./DALES_ProcessOutput002
