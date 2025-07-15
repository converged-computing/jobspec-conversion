#!/bin/bash
#FLUX: --job-name=angry-chair-4457
#FLUX: --urgency=16

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); cd /working_dir; rungwpso  /path/to/jsonfiles/allparamfiles.json"
