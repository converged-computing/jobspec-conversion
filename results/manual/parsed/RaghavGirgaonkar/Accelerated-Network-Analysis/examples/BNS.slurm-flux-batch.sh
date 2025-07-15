#!/bin/bash
#FLUX: --job-name=pusheena-motorcycle-8305
#FLUX: --urgency=16

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); rungwpso_bns allparamfiles.json"
