#!/bin/bash
#FLUX: --job-name=baseline_coverage
#FLUX: -c=25
#FLUX: --queue=main
#FLUX: -t=10800
#FLUX: --urgency=16

module load intel/17.0.4
module load R-Project/3.4.1
srun Rscript scripts/actual_diversity_coverage.R 
