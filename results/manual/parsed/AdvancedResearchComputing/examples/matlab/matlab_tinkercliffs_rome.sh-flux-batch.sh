#!/bin/bash
#FLUX: --job-name=delicious-chip-4555
#FLUX: --queue=dev_q
#FLUX: -t=600
#FLUX: --urgency=16

module reset
module load MATLAB
matlab -batch prime_batch_local
exit 0
