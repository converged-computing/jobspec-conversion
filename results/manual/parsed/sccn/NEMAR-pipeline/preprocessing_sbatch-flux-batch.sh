#!/bin/bash
#FLUX: --job-name=confused-lizard-7732
#FLUX: --queue=compute
#FLUX: --urgency=16

cd /home/dtyoung/NEMAR-pipeline
module load matlab
matlab -nodisplay -r "run_pipeline('ds003645');"
