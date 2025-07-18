#!/bin/bash
#FLUX: --job-name=rnavar
#FLUX: --urgency=16

export NXF_SINGULARITY_CACHEDIR='singularity'
export SINGULARITY_TMPDIR='$tmp'
export SINGULARITY_CACHEDIR='$tmp'

eval $(spack load --sh singularityce@3.8.0)
eval $(spack load --sh nextflow@22.04.5)
tmp=$(mktemp -d /tmp/$USER-singularity-XXXXXX)
mkdir local_tmp
mkdir tmp
export NXF_SINGULARITY_CACHEDIR=singularity
export SINGULARITY_TMPDIR=$tmp
export SINGULARITY_CACHEDIR=$tmp
wustl_conf=/scratch/mblab/chasem/configs/conf/wustl_htcf.config
params=$1
nextflow run /scratch/mblab/chasem/llfs_variant_calling/rnavar/main.nf \
  -profile singularity \
  -c $wustl_conf \
  -resume \
  -params-file $params
