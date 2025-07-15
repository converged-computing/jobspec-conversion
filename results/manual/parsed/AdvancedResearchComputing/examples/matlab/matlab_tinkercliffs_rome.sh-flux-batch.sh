#!/bin/bash
#FLUX: --job-name=bricky-parrot-9410
#FLUX: --urgency=16

module reset
module load MATLAB
matlab -batch prime_batch_local
exit 0
