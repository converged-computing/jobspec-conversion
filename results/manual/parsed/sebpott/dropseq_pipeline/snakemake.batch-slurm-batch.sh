#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=broadwl
#FLUX: -t=86400
#FLUX: --urgency=16

source activate dropseq
bash /project2/gilad/spott/Pipelines/dropseq_pipeline/Submit_snakemake.sh $*
