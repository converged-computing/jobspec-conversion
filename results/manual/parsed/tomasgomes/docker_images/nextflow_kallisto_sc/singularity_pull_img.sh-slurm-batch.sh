#!/bin/bash
#FLUX: --job-name=getnex
#FLUX: -c=4
#FLUX: -t=900
#FLUX: --urgency=16

singularity pull nextflow_kallisto_sc.sif docker://tomasgomes/nextflow_kallisto_sc:0.3
