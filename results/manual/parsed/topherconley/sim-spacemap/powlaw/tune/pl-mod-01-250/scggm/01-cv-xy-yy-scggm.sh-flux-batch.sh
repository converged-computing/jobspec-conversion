#!/bin/bash
#FLUX: --job-name=scggm
#FLUX: -c=31
#FLUX: --priority=16

set -e
set -v
module add matlab
/usr/bin/R --no-save --no-restore --no-site-file --no-init-file  --args ${SLURM_ARRAY_TASK_ID} 31 < 01-cv-xy-yy-scggm.R 
