#!/bin/bash
#FLUX: --job-name=creamy-earthworm-8737
#FLUX: -n=8
#FLUX: -t=18000
#FLUX: --urgency=16

pwd
echo "This is the R-batch-job running bayesian models of stream metabolism"
Rscript code/remote-met-run.R data/HOPB.rds
