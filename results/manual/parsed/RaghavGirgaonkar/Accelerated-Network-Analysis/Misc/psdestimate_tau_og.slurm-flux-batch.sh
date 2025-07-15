#!/bin/bash
#FLUX: --job-name=evasive-frito-2914
#FLUX: --priority=16

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/MFComparison-Testing_iMac; rungwpso  /work/09197/raghav/ls6/MFComparison-Testing_iMac/allparamfiles_og.json"
