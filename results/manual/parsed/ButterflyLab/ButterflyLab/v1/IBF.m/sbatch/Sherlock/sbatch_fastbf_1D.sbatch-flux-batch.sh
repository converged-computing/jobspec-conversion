#!/bin/bash
#FLUX: --job-name=fastbf_1D
#FLUX: --queue=bigmem
#FLUX: -t=57600
#FLUX: --urgency=16

module load matlab
cd ../../test/fio
matlab -nojvm -r "batch_fastbf_1D;quit"
