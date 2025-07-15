#!/bin/bash
#FLUX: --job-name=evasive-poo-6401
#FLUX: -t=21600
#FLUX: --urgency=16

cd /home/shawa/venka210/simMutualism || return
module purge
module load matlab
matlab -nodisplay -r "generatePlots('basicSweep', 'figsBasicSweep', 'plotOutcomes', true)"
