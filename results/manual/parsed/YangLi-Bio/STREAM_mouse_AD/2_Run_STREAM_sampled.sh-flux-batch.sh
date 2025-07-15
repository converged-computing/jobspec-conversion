#!/bin/bash
#FLUX: --job-name=Run_STREAM_sampled
#FLUX: -t=12059
#FLUX: --priority=16

set -e
cd /fs/ess/PCON0022/liyang/STREAM/Case_2_AD/Codes/
module load R/4.1.0-gnu9.1
Rscript 2_Test_STREAM.R
