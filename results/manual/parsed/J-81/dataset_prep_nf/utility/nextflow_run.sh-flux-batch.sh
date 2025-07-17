#!/bin/bash
#FLUX: --job-name=nf_wf_manage
#FLUX: -c=4
#FLUX: --queue=nodes
#FLUX: -t=86399
#FLUX: --urgency=16

nextflow pull J-81/dataset_prep_nf
nextflow run J-81/dataset_prep_nf \
  -r dev \
  -profile test \
  -with-tower \
  -resume
