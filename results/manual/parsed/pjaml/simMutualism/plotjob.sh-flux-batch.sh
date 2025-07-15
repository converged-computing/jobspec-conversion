#!/bin/bash
#FLUX: --job-name=arid-muffin-9380
#FLUX: -t=21600
#FLUX: --priority=16

cd /home/shawa/venka210/simMutualism || return
module purge
module load matlab
matlab -nodisplay -r "generatePlots('basicSweep', 'figsBasicSweep', 'plotOutcomes', true)"
