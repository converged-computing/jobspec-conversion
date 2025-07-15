#!/bin/bash
#FLUX: --job-name=EPMC
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=scavenge
#FLUX: -t=10500
#FLUX: --urgency=16

echo "I ran on:"
cd $SLURM_SUBMIT_DIR
echo $SLURM_NODELIST
grep MemTotal /proc/meminfo
lspci
module load MATLAB/2020a
matlab -nodisplay -r "main_epmc($X); quit"
