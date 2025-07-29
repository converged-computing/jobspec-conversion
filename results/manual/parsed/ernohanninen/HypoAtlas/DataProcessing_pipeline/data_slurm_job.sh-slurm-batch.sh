#!/bin/bash
#FLUX: --job-name=data
#FLUX: -c=5
#FLUX: -t=18000
#FLUX: --urgency=16

module load java/11.0.15 nextflow
nextflow run data_processing_wf.nf
