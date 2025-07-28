#!/bin/bash
#FLUX: --job-name=nf-T71
#FLUX: --queue=hgx
#FLUX: -t=2400
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/nesi/nobackup/uoa03709/containers/apptainer_cache'
export SINGULARITY_TMPDIR='/nesi/nobackup/uoa03709/containers/apptainer_tmpdir'

module purge
module load Singularity
module load Nextflow
export SINGULARITY_CACHEDIR=/nesi/nobackup/uoa03709/containers/apptainer_cache
export SINGULARITY_TMPDIR=/nesi/nobackup/uoa03709/containers/apptainer_tmpdir
mkdir -p $SINGULARITY_CACHEDIR $SINGULARITY_TMPDIR
setfacl -b $SINGULARITY_TMPDIR
nextflow run ckv1110/mcmicro --in T71GBM12_001/reg2 -profile singularity
