#!/bin/bash
#FLUX: --job-name=dbmt_process
#FLUX: -c=40
#FLUX: --queue=fuchs
#FLUX: -t=300
#FLUX: --priority=16

srun Rscript sim_stats.R
exit 0
