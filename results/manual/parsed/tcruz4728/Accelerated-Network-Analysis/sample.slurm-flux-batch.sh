#!/bin/bash
#FLUX: --job-name=placid-knife-1415
#FLUX: --priority=16

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); cd /working_dir; rungwpso  /path/to/jsonfiles/allparamfiles.json"
