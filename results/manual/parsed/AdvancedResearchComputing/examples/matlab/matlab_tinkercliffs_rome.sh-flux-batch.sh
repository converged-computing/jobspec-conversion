#!/bin/bash
#FLUX: --job-name=chocolate-peanut-butter-8654
#FLUX: --priority=16

module reset
module load MATLAB
matlab -batch prime_batch_local
exit 0
