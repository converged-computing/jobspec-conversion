#!/bin/bash
#FLUX: --job-name=multiomics_nextflow
#FLUX: -c=20
#FLUX: -t=720000
#FLUX: --urgency=16

nextflow run multiomics_nextflow.nf.groovy --data $1 --data_labels $2
