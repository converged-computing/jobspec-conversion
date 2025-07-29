#!/bin/bash
#FLUX --job-name=joyous-ricecake-5791
#FLUX -t=21600
#FLUX --urgency=16

cd /home/shawa/venka210/simMutualism || return
module purge
module load matlab
matlab -nodisplay -r "generatePlots('basicSweep', 'figsBasicSweep', 'plotOutcomes', true)"
