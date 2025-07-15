#!/bin/bash
#FLUX: --job-name=conspicuous-bicycle-8905
#FLUX: -c=20
#FLUX: -t=720000
#FLUX: --priority=16

nextflow run multiomics_nextflow.nf.groovy --data $1 --data_labels $2
