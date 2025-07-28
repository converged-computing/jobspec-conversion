#!/bin/bash
#FLUX: --job-name=plinkinetti
#FLUX: -c=12
#FLUX: --urgency=16

srun Rscript job.R
