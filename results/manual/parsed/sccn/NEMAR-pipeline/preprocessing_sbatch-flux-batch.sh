#!/bin/bash
#FLUX: --job-name=ds003645
#FLUX: --queue=compute
#FLUX: -t=86400
#FLUX: --urgency=16

cd /home/dtyoung/NEMAR-pipeline
module load matlab
matlab -nodisplay -r "run_pipeline('ds003645');"
