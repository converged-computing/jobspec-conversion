#!/bin/bash
#FLUX: --job-name=dask-workers
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: --urgency=16

export MODULEPATH='/share/apps/compute/modulefiles/applications:$MODULEPATH'

export MODULEPATH=/share/apps/compute/modulefiles/applications:$MODULEPATH
module load anaconda
ibrun --npernode=1 dask-worker --scheduler-file ~/.dask_scheduler.json
