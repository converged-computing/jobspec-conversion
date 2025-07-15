#!/bin/bash
#FLUX: --job-name="jupyter-notebook"
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --priority=16

export MODULEPATH='/share/apps/compute/modulefiles/applications:$MODULEPATH'

export MODULEPATH=/share/apps/compute/modulefiles/applications:$MODULEPATH
module load anaconda
jupyter notebook --no-browser --ip=*
