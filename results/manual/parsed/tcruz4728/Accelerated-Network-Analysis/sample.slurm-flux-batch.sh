#!/bin/bash
#FLUX: --job-name=sample
#FLUX: --queue=normal
#FLUX: -t=36000
#FLUX: --urgency=16

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); cd /working_dir; rungwpso  /path/to/jsonfiles/allparamfiles.json"
