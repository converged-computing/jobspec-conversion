#!/bin/bash
#FLUX: --job-name=EBcache
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: -t=3600
#FLUX: --priority=16

export LOGDIR='${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
set -x;
unset DRMAA_LIBRARY_PATH
eval "$($(which conda) shell.bash hook)"
conda activate snake-env;
echo $CONDA_PREFIX "activated";
DRMAA=" -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} -J {cluster.name} --nodes={cluster.nodes} -n {cluster.threads}";
DRMAA="$DRMAA -o ${LOGDIR}/{rule}-%j.log";
snakemake --snakefile cacheSnakefile --unlock --rerun-incomplete
snakemake --snakefile cacheSnakefile --cluster-config configs/cluster/PONcache-cluster.json --use-conda --rerun-incomplete --drmaa "$DRMAA" -j 3000 -p -r -k
