#!/bin/bash
#FLUX: --job-name=blank-latke-7855
#FLUX: -c=20
#FLUX: -t=720000
#FLUX: --urgency=16

nextflow run multiomics_nextflow.nf.groovy --data $1 --data_labels $2
