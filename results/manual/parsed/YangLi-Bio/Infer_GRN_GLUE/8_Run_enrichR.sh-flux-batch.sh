#!/bin/bash
#FLUX: --job-name=Run_enrichR
#FLUX: -t=42659
#FLUX: --priority=16

set -e
cd /fs/ess/PCON0022/liyang/STREAM/benchmarking/GLUE/Codes/
module load R/4.1.0-gnu9.1
Rscript 8_Run_enrichR.R
