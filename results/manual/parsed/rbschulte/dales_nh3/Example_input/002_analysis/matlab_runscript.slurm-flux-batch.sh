#!/bin/bash
#FLUX: --job-name=moolicious-snack-6150
#FLUX: --priority=16

module load 2021
module load MATLAB/2021a-upd3
echo "mcc -m DALES_ProcessOutput002.m" | matlab -nodisplay
./DALES_ProcessOutput002
