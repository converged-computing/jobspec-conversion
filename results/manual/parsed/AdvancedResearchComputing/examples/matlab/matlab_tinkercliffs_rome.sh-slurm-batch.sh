#!/bin/bash
#FLUX: --job-name=reclusive-ricecake-9400
#FLUX: --queue=dev_q
#FLUX: -t=600
#FLUX: --urgency=16

module reset
module load MATLAB
matlab -batch prime_batch_local
exit 0
