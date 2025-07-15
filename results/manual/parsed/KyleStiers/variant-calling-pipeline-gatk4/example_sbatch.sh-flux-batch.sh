#!/bin/bash
#FLUX: --job-name=hello-caramel-6286
#FLUX: -c=16
#FLUX: --urgency=16

nextflow run KyleStiers/variant-calling-pipeline-gatk4 -with-singularity KyleStiers/variant-calling-pipeline-gatk4
