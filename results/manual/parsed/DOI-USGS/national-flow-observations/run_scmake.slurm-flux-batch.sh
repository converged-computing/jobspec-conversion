#!/bin/bash
#FLUX: --job-name=boopy-underoos-3370
#FLUX: --queue=cpu
#FLUX: -t=172800
#FLUX: --urgency=16

module load singularity
srun singularity exec national-data-pulls_v0.1.sif Rscript -e '
library(scipiper);
options(scipiper.getters_file = "remake.yml"); 
scmake("30_data_summarize")'
