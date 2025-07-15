#!/bin/bash
#FLUX: --job-name=gloopy-puppy-8008
#FLUX: --priority=16

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); rungwpso_bns allparamfiles.json"
