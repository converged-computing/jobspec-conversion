#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: -t=72000
#FLUX: --urgency=16

export LOGDIR='${SNAKE_HOME}/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${SNAKE_HOME}/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
set -x;
unset DRMAA_LIBRARY_PATH
conda activate WES-env;
echo $CONDA_PREFIX "activated";
DRMAA=" -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} -J {cluster.name} --nodes={cluster.nodes} -n {cluster.threads}";
DRMAA="$DRMAA -o ${LOGDIR}/{rule}-%j.log";
snakemake --unlock --rerun-incomplete;
snakemake --dag | dot -Tsvg > dax/dag.svg;
snakemake --use-conda --rerun-incomplete --cluster-config configs/cluster/somvar-cluster.json --drmaa "$DRMAA" -prk -j 1000;
