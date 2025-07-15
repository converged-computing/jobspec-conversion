#!/bin/bash
#FLUX: --job-name=gloopy-mango-5360
#FLUX: --urgency=16

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/MFComparison-Testing_iMac; rungwpso  /work/09197/raghav/ls6/MFComparison-Testing_iMac/allparamfiles_og.json"
