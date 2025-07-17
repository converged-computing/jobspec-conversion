#!/bin/bash
#FLUX: --job-name=dask-workers
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: -t=7200
#FLUX: --urgency=16

export MODULEPATH='/share/apps/compute/modulefiles/applications:$MODULEPATH'
export PYTHONPATH='/.local/lib/python3.5/site-packages/:$PYTHONPATH'

export MODULEPATH=/share/apps/compute/modulefiles/applications:$MODULEPATH
module load anaconda
export PYTHONPATH=/.local/lib/python3.5/site-packages/:$PYTHONPATH
ibrun --npernode=1 ~/.local/bin/dask-worker --scheduler-file ~/.dask_scheduler.json
