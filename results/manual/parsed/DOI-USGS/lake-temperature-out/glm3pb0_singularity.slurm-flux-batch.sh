#!/bin/bash
#FLUX: --job-name=thermalmetrics
#FLUX: -c=72
#FLUX: --queue=cpu
#FLUX: -t=172800
#FLUX: --urgency=16

module load singularity/3.3.0
ulimit -u 1541404
srun singularity exec \
    lake-temperature-out.sif \
    Rscript glm3pb0_run.R
