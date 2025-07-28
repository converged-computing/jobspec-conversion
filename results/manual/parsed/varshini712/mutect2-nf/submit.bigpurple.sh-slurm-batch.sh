#!/bin/bash
#FLUX: --job-name=NGS580-GATK4_test
#FLUX: -c=8
#FLUX: --queue=intellispace
#FLUX: -t=432000
#FLUX: --urgency=16

./nextflow run main.nf
