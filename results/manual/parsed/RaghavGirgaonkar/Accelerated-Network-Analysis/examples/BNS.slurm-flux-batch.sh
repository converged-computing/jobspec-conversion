#!/bin/bash
#FLUX: --job-name=BNS
#FLUX: --queue=normal
#FLUX: -t=36000
#FLUX: --urgency=16

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); rungwpso_bns allparamfiles.json"
