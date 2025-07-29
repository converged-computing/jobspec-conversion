#!/bin/bash
#FLUX: --job-name=ref_h3a_mis
#FLUX: -n=2
#FLUX: --queue=Main
#FLUX: -t=864000
#FLUX: --urgency=16

cd /cbio/users/mamana/refimpute
nextflow \
    ~/refimpute/process_ref_h3a_mis.nf \
    -c /cbio/projects/001/clients/refimpute/process_ref_h3a_mis_v4.config \
    -profile singularity,slurm \
    -resume
