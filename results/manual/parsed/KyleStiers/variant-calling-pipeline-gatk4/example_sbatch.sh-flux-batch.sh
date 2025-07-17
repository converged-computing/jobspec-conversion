#!/bin/bash
#FLUX: --job-name=nf-custom-gat4k
#FLUX: -c=16
#FLUX: --queue=Lewis
#FLUX: -t=600
#FLUX: --urgency=16

nextflow run KyleStiers/variant-calling-pipeline-gatk4 -with-singularity KyleStiers/variant-calling-pipeline-gatk4
