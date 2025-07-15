#!/bin/bash
#FLUX: --job-name=riboseq-flow-test
#FLUX: --queue=cpu
#FLUX: -t=86400
#FLUX: --priority=16

export NXF_SINGULARITY_CACHEDIR='/nemo/lab/ulej/home/shared/singularity'
export NXF_HOME='/nemo/lab/ulej/home/users/luscomben/users/iosubi/.nextflow'

module purge
ml Nextflow/21.10.3
ml Singularity/3.6.4
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/ulej/home/shared/singularity
export NXF_HOME=/nemo/lab/ulej/home/users/luscomben/users/iosubi/.nextflow
nextflow pull iraiosub/riboseq-flow -r v1.0.1
nextflow run iraiosub/riboseq-flow -r v1.0.1 \
-profile test,singularity
