#!/bin/bash
#FLUX: --job-name=reclusive-bike-1644
#FLUX: -n=4
#FLUX: --queue=small
#FLUX: -t=600
#FLUX: --urgency=16

module load r-env-singularity
if test -f ~/.Renviron; then
    sed -i '/TMPDIR/d' ~/.Renviron
fi
srun singularity_wrapper exec RMPISNOW --no-save -f rtest.R
