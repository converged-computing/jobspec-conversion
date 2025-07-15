#!/bin/bash
#FLUX: --job-name=gassy-frito-0706
#FLUX: --queue=compute
#FLUX: --priority=16

cd /home/dtyoung/NEMAR-pipeline
module load matlab
matlab -nodisplay -r "run_pipeline('ds003645');"
