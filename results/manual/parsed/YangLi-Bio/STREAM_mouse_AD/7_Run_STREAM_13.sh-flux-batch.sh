#!/bin/bash
#FLUX: --job-name=Run_STREAM_13+_months
#FLUX: -t=123659
#FLUX: --priority=16

set -e
cd /fs/ess/PCON0022/liyang/STREAM/Case_2_AD/Codes/
module load R/4.1.0-gnu9.1
Rscript 7_STREAM_13.R
