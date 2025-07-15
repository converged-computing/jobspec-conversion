#!/bin/bash
#FLUX: --job-name=integration
#FLUX: -t=345600
#FLUX: --urgency=16

module load java/11.0.15 nextflow
nextflow run main.nf -c pipeline.config
