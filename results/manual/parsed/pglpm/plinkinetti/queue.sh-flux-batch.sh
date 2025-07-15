#!/bin/bash
#FLUX: --job-name=plinkinetti
#FLUX: -c=12
#FLUX: --priority=16

srun Rscript job.R
