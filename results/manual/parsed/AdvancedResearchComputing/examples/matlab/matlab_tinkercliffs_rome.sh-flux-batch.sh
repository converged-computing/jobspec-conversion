#!/bin/bash
#FLUX: --job-name=blank-kerfuffle-6218
#FLUX: --queue=dev_q
#FLUX: -t=600
#FLUX: --urgency=16

module reset
module load MATLAB
matlab -batch prime_batch_local
exit 0
