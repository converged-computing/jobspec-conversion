#!/bin/bash
#FLUX: --job-name=02-sc
#FLUX: -c=17
#FLUX: --urgency=16

set -e
set -v
module add matlab
/usr/bin/R --no-save --no-restore --no-site-file --no-init-file  --args ${SLURM_ARRAY_TASK_ID} 17 < 02-cv-xy-yy-scggm.R 
