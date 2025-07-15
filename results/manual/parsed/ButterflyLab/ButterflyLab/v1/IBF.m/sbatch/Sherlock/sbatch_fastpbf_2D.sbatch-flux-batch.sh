#!/bin/bash
#FLUX: --job-name=fastpbf_2D
#FLUX: --queue=bigmem
#FLUX: -t=57600
#FLUX: --priority=16

module load matlab
cd ../../test/fio
matlab -nojvm -r "batch_fastpbf_2D;quit"
