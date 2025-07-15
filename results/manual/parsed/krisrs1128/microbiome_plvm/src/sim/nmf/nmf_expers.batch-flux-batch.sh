#!/bin/bash
#FLUX: --job-name=nmf_expers
#FLUX: -t=144000
#FLUX: --priority=16

module load llvm/4.0.0
module load R/3.4.0
module load python/3.6.1
cd /scratch/users/kriss1/programming/research/microbiome_plvm/src/sim/nmf/
Rscript nmf_expers.R
