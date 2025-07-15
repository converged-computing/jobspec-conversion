#!/bin/bash
#FLUX: --job-name=NXTFLW
#FLUX: --priority=16

export NXF_EXECUTOR='slurm'
export NXF_OPTS='-Xms2G -Xmx8G" '
export NXF_SINGULARITY_CACHEDIR='${HOME}/singularity_cache'
export XDG_RUNTIME_DIR='${HOME}/xdr'

source "${HOME}/mambaforge/etc/profile.d/mamba.sh"
source activate nextflow
mamba activate nextflow
which nextflow
which singularity
export NXF_EXECUTOR=slurm
export NXF_OPTS="-Xms2G -Xmx8G" 
mkdir -p ${HOME}/singularity_cache
export NXF_SINGULARITY_CACHEDIR=${HOME}/singularity_cache
mkdir -p ${HOME}/xdr
export XDG_RUNTIME_DIR=${HOME}/xdr
nextflow run -profile slurm . --param_name nextflow.config -resume
