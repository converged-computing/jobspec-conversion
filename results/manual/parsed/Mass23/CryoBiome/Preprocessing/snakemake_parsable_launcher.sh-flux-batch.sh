#!/bin/bash
#FLUX: --job-name=lovely-lizard-2376
#FLUX: -t=432000
#FLUX: --priority=16

export PYTHONNOUSERSITE='TRUE'

IMP_ENV="snakemake"
IMP_CORES=20
IMP_JOBS=20
IMP_CONFIG="config.yaml" # USER INPUT REQUIRED
IMP_SLURM="slurm.yaml"
IMP_CLUSTER="{cluster.call} {cluster.runtime} {cluster.threads}{threads} {cluster.partition} {cluster.nodes} {cluster.quality} --job-name={cluster.job-name}"
conda activate ${IMP_ENV}
export PYTHONNOUSERSITE=TRUE
snakemake -s snakefile -rp --jobs ${IMP_JOBS} --local-cores 1 --configfile ${IMP_CONFIG} \
--use-conda --conda-prefix ${CONDA_PREFIX}/IMP --cluster-config ${IMP_SLURM} --cluster "${IMP_CLUSTER}" 
