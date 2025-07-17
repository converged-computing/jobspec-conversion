#!/bin/bash
#FLUX: --job-name=boopy-general-3473
#FLUX: -n=12
#FLUX: -t=172800
#FLUX: --urgency=16

pwd
echo "This is the R-batch-job running bayesian models of stream metabolism"
Rscript code/remote-met-mm-summ.R output/models/REDB_mm.rds
echo "Script finished"
